module HasLocalCache

  module RequestCache

    def self.reset_request_cache
      Thread.current[:request_cache] = nil
    end

    def self.get_cache(key, &block)
      rv = thread_cache[key]
      if rv.nil? && block_given?
        rv = set_cache(key, yield)
      end
      rv
    end

    def self.set_cache(key, val)
      thread_cache[key] = val
    end

    def self.thread_cache
      Thread.current[:request_cache] ||= {}
    end

  end

  module CommonMethods
    def get_cache_with_local_cache(key, &block)
      HasLocalCache::RequestCache.get_cache(cache_key(key)) do
        get_cache_without_local_cache key, &block
      end
    end
  end

  module ClassMethods
    include CommonMethods
  end

  module InstanceMethods
    include CommonMethods
  end

  module Mixin
    def has_local_cache
      extend  ClassMethods
      include InstanceMethods

      class << self
        alias_method_chain :get_cache, :local_cache
      end
      alias_method_chain :get_cache, :local_cache
    end
  end

end