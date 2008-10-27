require File.join(File.dirname(__FILE__), '../lib/has_local_cache.rb')

require 'test/unit'

class HasLocalCacheTest < Test::Unit::TestCase

  def teardown
    HasLocalCache::RequestCache::reset_request_cache
    super
  end

  def test_nil_get
    assert_nil(HasLocalCache::RequestCache.get_cache('x'))
  end

  def test_get_with_block
    assert_equal(5, HasLocalCache::RequestCache.get_cache('x') { 5 })
    assert_equal(5, HasLocalCache::RequestCache.get_cache('x'))
  end

  def test_get_with_set
    assert_nil(HasLocalCache::RequestCache.get_cache('x'))
    HasLocalCache::RequestCache.set_cache('x', 13)
    assert_equal(13, HasLocalCache::RequestCache.get_cache('x'))
  end

end
