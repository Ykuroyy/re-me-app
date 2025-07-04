#!/usr/bin/env bash
# Production database setup script
# Run this manually if the build process fails

echo "Setting up production database..."

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL environment variable is not set"
    exit 1
fi

echo "DATABASE_URL is configured"

# Run migrations
echo "Running database migrations..."
bundle exec rake db:migrate

# Check migration status
echo "Checking migration status..."
bundle exec rake db:migrate:status

echo "Production database setup completed!" 