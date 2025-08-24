ENV['RACK_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'

DB = Sequel.connect(ENV["DATABASE_URL"])
