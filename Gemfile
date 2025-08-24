# Gemfile
source "https://rubygems.org"

gem "sinatra", require: "sinatra/base"
gem "sequel"
gem "pg"
gem "rack", "~> 2.2", require: "rack"
gem "rack-protection"
gem "rack-accept"
gem "dotenv"
gem "rake"
gem 'foreman'
gem "json"
gem "rackup"
gem "puma"
gem "que"
gem "mail"
gem "ostruct"

# added to the Gemfile
group :production do
  gem "logger"
  gem "rollbar"
  gem "rack-ssl-enforcer"
  gem "rack-cors"
  gem "rack-attack"
  gem "redis"
  gem "oj"
  gem "shrine"
end

group :development, :test do
  gem "factory_bot"
  gem "faker"
  gem 'awesome_print'
  gem 'pry'
  gem 'minitest'
  gem 'rack-test'
end
