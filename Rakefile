# frozen_string_literal: true

require 'sequel'
require 'dotenv'
require 'yaml'
require 'fileutils'
require 'uri'
require 'sequel/extensions/migration'

ENV['RACK_ENV'] ||= 'development'
Dotenv.load(".env.#{ENV['RACK_ENV']}") if File.exist?(".env.#{ENV['RACK_ENV']}")

namespace :db do
  def db_url
    ENV['DATABASE_URL'] || raise('DATABASE_URL not set')
  end

  def db_name_from_url(url)
    URI.parse(url).path[1..]
  end

  def bootstrap_url(url)
    uri = URI.parse(url)
    user = uri.user
    password = uri.password
    host = uri.host
    port = uri.port || 5432
    "postgres://#{user}:#{password}@#{host}:#{port}/postgres"
  end

  task :connect do
    @db = Sequel.connect(db_url)
  end

  desc 'Create the database if it does not exist'
  task :create do
    url = db_url
    db_name = db_name_from_url(url)
    b_url = bootstrap_url(url)
    bootstrap_db = Sequel.connect(b_url)

    if bootstrap_db.fetch('SELECT 1 FROM pg_database WHERE datname = ?', db_name).any?
      puts "⚠️  Database #{db_name} already exists"
    else
      bootstrap_db.run(%(CREATE DATABASE "#{db_name}"))
      puts "✅ Created database #{db_name}"
    end
  end

  desc 'Run migrations'
  task migrate: :connect do
    migration_dir = 'db/migrate'
    unless Dir.exist?(migration_dir) && Dir.glob("{migration_dir}/*.rb").any?
      puts "⚠️  No migration files found in #{migration_dir}. Skipping."
      next
    end

    begin
      Sequel::Migrator.run(@db, migration_dir)
      puts '✅ Migrations applied.'
    rescue Sequel::Migrator::Error => e
      warn "❌ Migration error: #{e.message}"
      warn '   Tip: You might have an orphaned migration in the DB.'
      exit 1
    end
  end

  desc 'Create migration'
  task :create_migration, [:name] => :connect do |_, args|
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    name = args[:name] || 'new_migration'
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


  desc 'Open an interactive console with app context'
  task :console do
    require 'irb'
    require_relative './config/environment'

    puts "🔧 Loading Sinatra console (#{ENV['RACK_ENV']})..."
    IRB.setup(nil)
    workspace = IRB::WorkSpace.new(binding)
    irb = IRB::Irb.new(workspace)
    IRB.conf[:MAIN_CONTEXT] = irb.context
    trap('SIGINT') { irb.signal_handle }
    irb.eval_input
  end


  desc "Run Que's migration to create que_jobs table"
  task :que_migrate do
    require_relative './config/environment'
    require 'que'
    Que.migrate!(version: 6)
    puts '✅ Que migration complete.'
  end

  desc 'Setup: create, migrate'
  task setup: %i[create migrate]
end
