source 'https://rubygems.org'
ruby '2.4.1'

gem 'rails', '~> 5.1.1'

gem 'puma', '~> 3.7'

gem 'active_model_serializers', '~> 0.10.0'
gem 'bcrypt'
gem 'pundit'
gem 'searchlight'
gem 'kaminari'
gem 'pg', '~> 0.15'
gem 'jwt'

gem 'rack-cors'

group :development, :test do
  #Manage ENV variables
  gem 'dotenv-rails'
  # Testing
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver', '~> 2.48.1'
  gem 'faker'
  gem 'database_cleaner', '~> 1.5'
  #Debug and Dev
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem "better_errors" #better error screen
  gem "binding_of_caller" #for better error best support
  gem 'pry-rescue' #with bundle exec rescue rails server init rescue and open pry on wach exception not rescued. also rescue rspec
  gem 'awesome_print' #beatiful puts.!
  gem 'pry-state' #session pry state - variables on screen alternative pry-inline
  gem 'foreman'
end


group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]