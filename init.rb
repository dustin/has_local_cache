require 'has_local_cache'

ActionController::Base.send :after_filter do
  HasLocalCache::RequestCache::reset_request_cache
end

Object.send :include, HasLocalCache::Mixin
