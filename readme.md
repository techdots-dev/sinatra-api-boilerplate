# Sinatra Boilerplate

A modern, modular Sinatra API boilerplate with Sequel ORM, PostgreSQL, and best practices for rapid API development.

## Features
- Modular Sinatra app structure (using `Sinatra::Base`)
- Sequel ORM with PostgreSQL
- Environment-based configuration
- Basic authentication middleware
- JSON API responses
- Rack protection and security best practices
- Rake tasks for database management
- Foreman/Procfile for easy process management

## Getting Started

### Prerequisites
- Ruby 3.4+
- PostgreSQL
- Bundler (`gem install bundler`)

### Setup
1. **Clone the repository:**
   ```sh
   git clone git@github.com:techdots-dev/Sinatra-Boilerplate.git
   cd Sinatra-Boilerplate
   ```
2. **Install dependencies:**
   ```sh
   bundle install
   ```
3. **Configure environment:**
   - Copy `.env.example` to `.env` and set your environment variables (e.g., `DATABASE_URL`, `BASIC_AUTH_USER`, `BASIC_AUTH_PASSWORD`).
   - Edit `config/database.yml` for your local DB settings.
4. **Setup the database:**
   ```sh
   bundle exec rake db:create db:migrate db:seed
   ```
5. **Start the app:**
   ```sh
   foreman start
   # or
   bundle exec rackup config.ru
   ```

## Project Structure
```
app.rb                  # Main Sinatra app (classic style)
app/
  base.rb               # Base class for modular controllers
  controllers/
    users_controller.rb # Example Users API controller
  models/
    user.rb             # User model (Sequel)
config/
  environment.rb        # Loads app environment
  initializers/
    database.rb         # Sequel DB setup and plugins
  database.yml          # DB config per environment
db/
  migrate/              # Sequel migrations
  seeds/                # Seed scripts
lib/
  middleware/
    basic_auth.rb       # Basic Auth middleware
Procfile                # For Foreman process management
Rakefile                # Rake tasks for DB
config.ru               # Rackup file
Gemfile                 # Gem dependencies
```

## API Endpoints

### Users
- `GET /api/users` — List all users
- `POST /api/users` — Create a new user (JSON body: `{ "name": "...", "email": "..." }`)

## Security
- All API endpoints require `Accept: application/json` header.
- Basic authentication is required for protected routes (see `.env` for credentials).

## Development
- Use `pry` for debugging.
- Add new controllers in `app/controllers/` and mount them in your main app if using modular style.

## License
MIT
