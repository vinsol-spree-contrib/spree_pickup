# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_pickup'
  s.version     = '3.1.0'
  s.summary     = 'User can select pickup location for any of the order'
  s.description = 'User can select pickup location for any of the order'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Gurpreet Singh'
  s.email     = 'info@vinsol.com'
  # s.homepage  = 'http://www.spreecommerce.com'
  s.license = 'BSD-3'

  # s.files       = `git ls-files`.split("\n")
  # s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 3.2.0', '< 4.0.0'

  s.add_dependency 'spree_api',         spree_version
  s.add_dependency 'spree_backend',     spree_version
  s.add_dependency 'spree_core',        spree_version
  s.add_dependency 'spree_frontend',    spree_version
  s.add_dependency 'spree_extension',   '~> 0.0.5'

  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'capybara', '~> 2.6'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'rspec-rails', '~> 3.4'
  s.add_development_dependency 'sass-rails', '~> 5.0.0'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'shoulda-callback-matchers'
  s.add_dependency 'geocoder'
end
