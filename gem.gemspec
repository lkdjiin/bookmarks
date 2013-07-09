# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = 'bookmarks'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = 'Bookmarks is a library to parse or build a file of bookmarks.'
  s.homepage = 'https://github.com/lkdjiin/bookmarks'
  s.description = %q{Bookmarks is a library to parse or build a file of
bookmarks, currently only files in netscape format, like the ones
exported by Delicious.}
	
	readmes = FileList.new('*') do |list|
		list.exclude(/(^|[^.a-z])[a-z]+/)
		list.exclude('TODO')
	end.to_a
  s.files = FileList['lib/**/*.rb', '[A-Z]*'].to_a + readmes
	s.license = 'MIT'
	s.required_ruby_version = '>= 2.0.0'
  # s.add_dependency 'xxx', '>= 0.4.2'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'coco', '>= 0.7.1'
  s.add_development_dependency('yard')
  s.add_development_dependency('yard-tomdoc')
end
