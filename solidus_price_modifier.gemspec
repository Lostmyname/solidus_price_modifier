# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_price_modifier'
  s.version     = '0.0.1'
  s.summary     = 'Price Modifier Pricer for Solidus'
  s.description = 'Deprecated Price modifying behaviour'
  s.required_ruby_version = '>= 2.1'

  s.author    = 'Martin Meyerhoff'
  s.email     = 'martin@stembolt.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = "lib"
  s.requirements << "none"

  s.add_dependency "solidus", [">= 1.3.0", "< 1.5"]

  s.add_development_dependency "rspec-rails", "~> 3.2"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pg"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "coffee-rails"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "ffaker"
end
