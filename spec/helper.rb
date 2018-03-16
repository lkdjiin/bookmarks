require 'coco'

require './lib/bookmarks'
include Bookmarks

RSpec.configure do |config|
  config.order = "random"
end

def fixture_file filename
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read file_path
end

def fixture_file_path filename
  File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
end

