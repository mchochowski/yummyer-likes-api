# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'jsonapi-serializer'
gem 'mongoid', '~> 7.2.0'
gem 'oj'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
end

group :test do
  gem 'database_cleaner-mongoid'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
