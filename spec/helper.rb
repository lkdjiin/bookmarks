# -*- encoding: utf-8 -*-

require 'coco'

require './lib/bookmarks'
include Bookmarks

RSpec.configure do |config|
  config.order = "random"
end

