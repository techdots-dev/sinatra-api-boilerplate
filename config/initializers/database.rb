require "yaml"

db_config = YAML.load_file("config/database.yml")
env = ENV["RACK_ENV"] || "development"
DB = Sequel.connect(db_config[env])

Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :validation_helpers
Sequel::Model.raise_on_save_failure = true
