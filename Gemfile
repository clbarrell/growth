source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use PostgresSql
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# group_by_date functions
gem 'groupdate'
# graphing!
gem 'chartkick'
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'puma'
# SECURITY
gem 'devise'
gem "omniauth-google-oauth2"
gem 'omniauth'
gem "figaro"

# DELAYED JOBS
# https://github.com/collectiveidea/delayed_job
gem 'delayed_job_active_record'
gem 'daemons'
# https://github.com/lostboy/workless
# gem "workless", "~> 1.1.3"
gem 'platform-api'

# MAIL
gem 'premailer-rails'
gem 'nokogiri'

# LOGGING
gem "intercom-rails"

group :production do
  # webserver for production
  gem "rack-timeout"
  gem 'rails_12factor'
end
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem "factory_girl_rails", "~> 4.0"
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "better_errors"
  gem "binding_of_caller"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
ruby "2.3.1"
