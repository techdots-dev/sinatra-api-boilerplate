require 'rack/ssl-enforcer'

# In config.ru, add:
# use Rack::SslEnforcer if ENV['RACK_ENV'] == 'production'
