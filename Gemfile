source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.2.2'
gem 'mysql2', '~> 0.5.3'
gem 'puma', '~> 4.3'
gem 'webpacker', '~> 4.2', '>= 4.2.2'
gem 'jbuilder', '~> 2.9', '>= 2.9.1'
gem 'bootsnap', '~> 1.4', '>= 1.4.5', require: false
gem 'tzinfo-data', '~> 1.2019', '>= 1.2019.3'

# Delete these if using React/other for FE - START
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
# Delete these if using React/other for FE - END

group :development, :test do
  gem 'byebug', '~> 11.0', '>= 11.0.1', platforms: [:mri, :mingw, :x64_mingw]

  # Custom gems:
  gem 'database_cleaner', '~> 1.7'
  gem 'simplecov', '~> 0.17.1'
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.2'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
  gem 'rspec-rails', '~> 3.9'
  gem 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  gem 'faker', '~> 2.9'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.0', '>= 4.0.1'
  gem 'listen', '~> 3.2', '>= 3.2.1'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'

  # Custom gems:
  gem 'brakeman', '~> 4.7', '>= 4.7.2'
  gem 'bundler-audit', '~> 0.6.1'
end

group :test do
  gem 'capybara', '~> 3.29'
  gem 'selenium-webdriver', '~> 3.142', '>= 3.142.6'
  gem 'webdrivers', '~> 4.1', '>= 4.1.3'
end

## Custom Gems:
gem 'figaro', '~> 1.1', '>= 1.1.1'