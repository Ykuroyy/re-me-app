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
bundle exec rake db:create 2>/dev/null || echo "Database already exists or creation failed"
bundle exec rake db:migrate
bundle exec rake db:seed 2>/dev/null || echo "Seeding skipped (production environment)"

echo "Build completed successfully!" 