# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = 'bookmarks_file'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = ''
  s.homepage = ''
  s.description = %q{}
	
	readmes = FileList.new('*') do |list|
		list.exclude(/(^|[^.a-z])[a-z]+/)
		list.exclude('TODO')
	end.to_a
  s.files = FileList['lib/**/*.rb', '[A-Z]*'].to_a + readmes
	s.license = ''
	s.required_ruby_version = '>= 2.0.0'
  # s.add_dependency 'xxx', '>= 0.4.2'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coco', '>= 0.7.1'
  s.add_development_dependency('yard')
  s.add_development_dependency('yard-tomdoc')
end
