# Has Local Cache

An in-process cache that resets at the end of a request.

Memcached is fast, but an app can get really slow if it's hit too frequently.
Some things should be considered valid throughout a request.  This helps with
those things.

I may fold this functionality into cache\_fu itself, but this plugin will at
least help me (and you) get some experience with in-process caches first.

# Usage

    class SomeModel < ActiveRecord::Base
      acts_as_cached
      has_local_cache
    end

    SomeModel.get_cache('somekey') do
      # Some expensive code that will run if the local cache
      # and memcached both return nothing.
    end

Copyright (c) 2008 Dustin Sallings, released under the MIT license
