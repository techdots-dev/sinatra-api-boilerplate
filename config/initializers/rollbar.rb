require 'rollbar'

unless ENV['RACK_ENV'] == ('test' || 'development')
  Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
    config.environment = ENV['RACK_ENV'] || 'development'
    config.framework = "Sinatra: #{Sinatra::VERSION}"
    config.root = Dir.pwd
  end
end
