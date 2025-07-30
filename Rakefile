# Rakefile
require "sequel"
require "dotenv"
require "yaml"
require "fileutils"
require "uri"
require "sequel/extensions/migration"

ENV["RACK_ENV"] ||= "development"
Dotenv.load(".env.#{ENV["RACK_ENV"]}") if File.exist?(".env.#{ENV["RACK_ENV"]}")

namespace :db do
  task :connect do
    @db = Sequel.connect(ENV["DATABASE_URL"])
  end

  desc "Create the database if it doesn't exist"
  task :create do
    raise "DATABASE_URL not set" unless ENV["DATABASE_URL"]

    uri = URI.parse(ENV["DATABASE_URL"])
    db_name = uri.path[1..] # remove leading slash
    user = uri.user
    password = uri.password
    host = uri.host
    port = uri.port || 5432

    # Connect to the default 'postgres' DB
    bootstrap_url = "postgres://#{user}:#{password}@#{host}:#{port}/postgres"
    bootstrap_db = Sequel.connect(bootstrap_url)

    unless bootstrap_db.fetch("SELECT 1 FROM pg_database WHERE datname = ?", db_name).any?
      bootstrap_db.run("CREATE DATABASE \"#{db_name}\"")
      puts "✅ Created database #{db_name}"
    else
      puts "⚠️  Database #{db_name} already exists"
    end
  end

  desc "Run migrations"
  task migrate: :connect do
    migration_dir = "db/migrate"
    unless Dir.exist?(migration_dir) && Dir.glob("#{migration_dir}/*.rb").any?
      puts "⚠️  No migration files found in #{migration_dir}. Skipping."
      next
    end

    begin
      Sequel::Migrator.run(@db, migration_dir)
      puts "✅ Migrations applied."
    rescue Sequel::Migrator::Error => e
      puts "❌ Migration error: #{e.message}"
      puts "   Tip: You might have an orphaned migration in the DB."
      exit 1
    end
  end

  desc "Create migration"
  task :create_migration, [:name] => :connect do |_, args|
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    name = args[:name] || "new_migration"
    file = "db/migrate/#{timestamp}_#{name}.rb"
    File.write(file, <<~RUBY)
      Sequel.migration do
        change do
          # Example:
          # create_table(:users) do
          #   primary_key :id
          #   String :name
          #   String :email
          #   DateTime :created_at
          #   DateTime :updated_at
          # end
        end
      end
    RUBY
    puts "✅ Created migration: #{file}"
  end

  desc "Open an interactive console with app context"
  task :console do
    require "irb"
    require_relative "./config/environment"

    puts "🔧 Loading Sinatra console (#{ENV['RACK_ENV']})..."
    IRB.setup(nil)
    workspace = IRB::WorkSpace.new(binding)
    irb = IRB::Irb.new(workspace)
    IRB.conf[:MAIN_CONTEXT] = irb.context
    trap("SIGINT") { irb.signal_handle }
    irb.eval_input
  end


  desc "Setup: create, migrate"
  task setup: [:create, :migrate]
end
