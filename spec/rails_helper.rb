ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
# Add additional requires below this line. Rails is not loaded until this point!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/modules/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema! # If you are not using ActiveRecord, you can remove this line.

Capybara.server_port = 9888
Capybara.javascript_driver = :selenium #:webkit

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.order = 'random'

  config.infer_base_class_for_anonymous_controllers = true
  config.infer_spec_type_from_file_location! # The different available types are documented in the features, such as in https://relishapp.com/rspec/rspec-rails/docs
  
end
