# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', github: 'rails/rails'

gem 'bootstrap'
gem 'bundler'
gem 'coffee-rails'
gem 'jbuilder'
gem 'jquery-rails', '>= 4.3.5'
gem 'kaminari'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'pg'
gem 'puma'
gem 'rack-user_agent'
gem 'sass-rails'
gem 'slim'
gem 'turbolinks'
gem 'twitter'
gem 'uglifier'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 3.27.0'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'selenium-webdriver'
  gem 'webdrivers', '>= 4.1.2'
  gem 'webmock'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end
