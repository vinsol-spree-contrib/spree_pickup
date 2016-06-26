# # Run Coverage report
# require 'simplecov'
# SimpleCov.start do
#   add_filter 'spec/dummy'
#   add_group 'Controllers', 'app/controllers'
#   add_group 'Helpers', 'app/helpers'
#   add_group 'Mailers', 'app/mailers'
#   add_group 'Models', 'app/models'
#   add_group 'Views', 'app/views'
#   add_group 'Libraries', 'lib'
# end

# # Configure Rails Environment
# ENV['RAILS_ENV'] = 'test'

# require File.expand_path('../dummy/config/environment.rb',  __FILE__)

# require 'rspec/rails'
# require 'database_cleaner'
# require 'ffaker'

# # Requires supporting ruby files with custom matchers and macros, etc,
# # in spec/support/ and its subdirectories.
# Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# # Requires factories and other useful helpers defined in spree_core.
# require 'spree/testing_support/authorization_helpers'
# require 'spree/testing_support/capybara_ext'
# require 'spree/testing_support/controller_requests'
# require 'spree/testing_support/factories'
# require 'spree/testing_support/url_helpers'

# # Requires factories defined in lib/spree_pickup/factories.rb
# require 'spree_pickup/factories'

# RSpec.configure do |config|
#   config.include FactoryGirl::Syntax::Methods

#   # Infer an example group's spec type from the file location.
#   config.infer_spec_type_from_file_location!

#   # == URL Helpers
#   #
#   # Allows access to Spree's routes in specs:
#   #
#   # visit spree.admin_path
#   # current_path.should eql(spree.products_path)
#   config.include Spree::TestingSupport::UrlHelpers

#   # == Requests support
#   #
#   # Adds convenient methods to request Spree's controllers
#   # spree_get :index
#   config.include Spree::TestingSupport::ControllerRequests, type: :controller

#   # == Mock Framework
#   #
#   # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
#   #
#   # config.mock_with :mocha
#   # config.mock_with :flexmock
#   # config.mock_with :rr
#   config.mock_with :rspec
#   config.color = true

#   # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
#   config.fixture_path = "#{::Rails.root}/spec/fixtures"

#   # Capybara javascript drivers require transactional fixtures set to false, and we use DatabaseCleaner
#   # to cleanup after each test instead.  Without transactional fixtures set to false the records created
#   # to setup a test will be unavailable to the browser, which runs under a separate server instance.
#   config.use_transactional_fixtures = false

#   # Ensure Suite is set to use transactions for speed.
#   config.before :suite do
#     DatabaseCleaner.strategy = :transaction
#     DatabaseCleaner.clean_with :truncation
#   end

#   # Before each spec check if it is a Javascript test and switch between using database transactions or not where necessary.
#   config.before :each do
#     DatabaseCleaner.strategy = RSpec.current_example.metadata[:js] ? :truncation : :transaction
#     DatabaseCleaner.start
#   end

#   # After each spec clean the database.
#   config.after :each do
#     DatabaseCleaner.clean
#   end

#   config.fail_fast = ENV['FAIL_FAST'] || false
#   config.order = "random"
# end


if ENV["COVERAGE"]
  # Run Coverage report
  require 'simplecov'
  SimpleCov.start do
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Models', 'app/models'
    add_group 'Views', 'app/views'
    add_group 'Jobs', 'app/jobs'
    add_group 'Libraries', 'lib'
  end
end

# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'

begin
  require File.expand_path("../dummy/config/environment", __FILE__)
rescue LoadError
  puts "Could not load dummy application. Please ensure you have run `bundle exec rake test_app`"
end

require 'rspec/rails'
require 'database_cleaner'
require 'ffaker'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

if ENV["CHECK_TRANSLATIONS"]
  require "spree/testing_support/i18n"
end

require 'spree/testing_support/factories'
require 'spree/testing_support/preferences'
# require 'spree/testing_support/shoulda_matcher_configuration'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/factories'
require 'spree/testing_support/url_helpers'

RSpec.configure do |config|
  config.color = true
  config.fail_fast = ENV['FAIL_FAST'] || false
  config.fixture_path = File.join(File.expand_path(File.dirname(__FILE__)), "fixtures")
  config.infer_spec_type_from_file_location!
  config.mock_with :rspec
  config.raise_errors_for_deprecations!

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.before :each do
    Rails.cache.clear
    reset_spree_preferences
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Spree::TestingSupport::Preferences

  # Clean out the database state before the tests run
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  # Wrap all db isolated tests in a transaction
  config.around(db: :isolate) do |example|
    DatabaseCleaner.cleaning(&example)
  end

  config.around do |example|
    Timeout.timeout(30, &example)
  end
end
