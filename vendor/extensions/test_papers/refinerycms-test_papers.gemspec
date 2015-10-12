# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-test_papers'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Test Papers extension for Refinery CMS'
  s.date              = '2013-04-21'
  s.summary           = 'Test Papers extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.10'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.10'
  s.authors       = ["Bishma Stornelli"]
end
