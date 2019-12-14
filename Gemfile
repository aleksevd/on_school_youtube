source 'https://rubygems.org'

ruby '2.3.6'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'

gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'bootstrap-sass'
gem 'bootstrap-select-rails'

gem 'slim-rails'
gem 'simple_form'
gem 'cocoon'

gem 'lightbox2-rails'

gem 'tinymce-rails'
gem 'tinymce-rails-imageupload', '~> 4.0.17.beta.3'

gem 'best_in_place'
gem 'gon'

gem 'russian', github: 'yaroslav/russian'

gem 'breadcrumbs_on_rails'
gem 'kaminari'
gem 'bootstrap-kaminari-views'

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

gem 'draper'
gem 'ransack'

gem 'devise'
gem 'authority'

gem 'state_machines-activerecord'
#gem 'after_commit_queue'

# gem 'sidekiq'
# gem 'sidekiq-failures'
# gem 'sidekiq-limit_fetch'
# gem 'sinatra', github: 'sinatra/sinatra', require: false

gem 'carrierwave'
gem 'carrierwave-i18n'
gem 'mini_magick'

gem 'acts_as_list'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails'

  gem 'pry-rails'
  gem 'pry-theme'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: :mri
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '~> 2.13'
  # gem 'selenium-webdriver'
end

group :development do
  gem 'priscilla'

  gem "better_errors"
  gem "binding_of_caller"
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  #gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  gem 'capistrano'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-scm-copy'
  gem 'capistrano3-puma'
end

group :test do
  gem 'shoulda-matchers', require: false

  gem 'timecop'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  # gem 'webmock'
  # gem 'vcr'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
