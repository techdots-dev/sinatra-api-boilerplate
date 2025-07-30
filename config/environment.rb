require "bundler/setup"
require "dotenv/load"

Bundler.require(:default, ENV["RACK_ENV"] || "development")

ENV["RACK_ENV"] ||= "development"

Dir["./config/initializers/**/*.rb"].each { |f| require f }
Dir["./app/**/*.rb"].each { |f| require f }
