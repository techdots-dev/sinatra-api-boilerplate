
# Sinatra Boilerplate

A modern, modular Sinatra API boilerplate with Sequel ORM, PostgreSQL, and production best practices.

## Features
- Modular Sinatra app structure (`Sinatra::Base` controllers)
- Sequel ORM with PostgreSQL
- Environment-based configuration via dotenv
- Basic authentication middleware
- JSON API responses and content negotiation
- Health check endpoint (`/health`)
- Rack protection and security best practices
- Rake tasks for database management and Que jobs
- Foreman/Procfile for process management
- GitHub Actions CI for automated testing

## Getting Started

### Prerequisites
- Ruby 3.4+
- PostgreSQL
- Bundler (`gem install bundler`)

### Setup
1. **Clone the repository:**
   ```sh
   git clone git@github.com:techdots-dev/sinatra-boilerplate.git
   cd sinatra-boilerplate
   ```
2. **Install dependencies:**
   ```sh
   bundle install
   ```
3. **Configure environment:**
   - Copy `.env.example` to `.env` and set your environment variables (e.g., `DATABASE_URL`, `BASIC_AUTH_USER`, `BASIC_AUTH_PASSWORD`).
   - Edit `config/database.yml` for your local DB settings or use `DATABASE_URL`.
4. **Setup the database:**
   ```sh
   bundle exec rake db:create db:migrate
   ```
5. **Start the app:**
   ```sh
   foreman start
   # or
   bundle exec rackup config.ru
   ```

## Project Structure
```
app.rb                  # Main Sinatra app entrypoint
app/
  base.rb               # Base controller class
  controllers/
    users_controller.rb # Users API controller
    health_controller.rb# Health check controller
  models/
    user.rb             # User model (Sequel)
config/
  environment.rb        # Loads app environment
  initializers/
    database.rb         # Sequel DB setup and plugins
    rollbar.rb          # Rollbar error tracking config
  database.yml          # DB config per environment
db/
  migrate/              # Sequel migrations
lib/
  middleware/
    basic_auth.rb       # Basic Auth middleware
Procfile                # For Foreman process management
Rakefile                # Rake tasks for DB and Que jobs
config.ru               # Rackup file (mounts controllers)
Gemfile                 # Gem dependencies
.github/workflows/ci.yml# GitHub Actions CI config
```

## API Endpoints

### Health
- `GET /health` — Health check (returns JSON if requested)

### Users
- `GET /api/users` — List all users
- `POST /api/users` — Create a new user (JSON body: `{ "name": "...", "email": "..." }`)

## Security
- All API endpoints require `Accept: application/json` header for JSON responses.
- Basic authentication is required for protected routes (see `.env` for credentials).
- CORS enabled for all origins (customize in `config.ru` as needed).

## Development
- Use `pry` for debugging.
- Add new controllers in `app/controllers/` and mount them in `config.ru`.
- Write tests in `test/` using Minitest and Rack::Test.

## Health Check
- `/health` endpoint supports both browser and API clients.
- Returns simple "ok" for non-JSON requests, detailed JSON for API clients.

## License
MIT
