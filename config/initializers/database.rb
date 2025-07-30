require "yaml"

db_config = YAML.load_file("config/database.yml")
env = ENV["RACK_ENV"] || "development"
DB = Sequel.connect(db_config[env])

Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :validation_helpers
Sequel::Model.raise_on_save_failure = true

# Que setup
require 'que'
Que.connection = DB

# Mail gem setup (basic example, adjust as needed)
require 'mail'
Mail.defaults do
  delivery_method :smtp, address: "localhost", port: 1025
end
