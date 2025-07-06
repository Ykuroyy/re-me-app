#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Starting build process..."

# Install dependencies
echo "Installing dependencies..."
bundle install

# Precompile assets
echo "Precompiling assets..."
bundle exec rake assets:precompile
bundle exec rake assets:clean

# Database setup for production
echo "Setting up database..."

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL environment variable is not set"
    exit 1
fi

echo "DATABASE_URL is configured"

# Create database (ignore if already exists)
echo "Creating database..."
bundle exec rake db:create 2>/dev/null || echo "Database creation skipped (may already exist)"

# Run migrations with detailed output
echo "Running database migrations..."
bundle exec rake db:migrate

# Check migration status
echo "Checking migration status..."
bundle exec rake db:migrate:status

# Verify table exists
echo "Verifying table exists..."
bundle exec rails runner "puts 'Table exists: ' + GoodMemory.connection.table_exists?('good_memories').to_s"

# Skip seeding in production
echo "Skipping seed data (production environment)"

echo "Build completed successfully!" 