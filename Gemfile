source "https://rubygems.org"

gem "sinatra", "~>2.0.4"
gem "sinatra-contrib", "~>2.0.4"
gem "jwt", "~>2.1.0"
gem "json", "~>2.1.0"
gem "rack", "~>2.0.6"
gem "puma", "~>3.12"
gem "foreman", "~>0.64.0"
gem "activesupport", "~>5.2.2"
gem "rake", "~>12.3.2"
gem "sentry-raven", "~>2.7.4"
gem "activerecord", "~>5.2.2"
gem "sinatra-activerecord", "~>2.0.13"
gem "bcrypt", "~>3.1.12"
gem "rack-protection", "~>2.0.5"

group :test do
  gem "rspec", "~>3.8.0"
  gem "rack-test", "~>1.1.0"
  gem "database_cleaner", "~>1.7.0"
  gem "coveralls", require: false
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development, :test do
  gem "bundle-audit", "~>0.1.0"
  gem "mysql2", "~>0.5.2"
  gem "factory_bot", "~>4.11.1"
end

group :production do
  gem "pg", "~>1.1.3"
end
