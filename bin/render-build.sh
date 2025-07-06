#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Starting build process..."

# Install dependencies
echo "Installing dependencies..."
bundle install
bundle exec rails db:migrate

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

# Run migrations with retry logic
echo "Running database migrations..."
for i in {1..3}; do
    echo "Migration attempt $i of 3..."
    if bundle exec rake db:migrate; then
        echo "Migrations completed successfully!"
        break
    else
        echo "Migration attempt $i failed"
        if [ $i -eq 3 ]; then
            echo "All migration attempts failed. Exiting."
            exit 1
        fi
        sleep 5
    fi
done

# Check migration status
echo "Checking migration status..."
bundle exec rake db:migrate:status

# Verify table exists with retry
echo "Verifying table exists..."
for i in {1..3}; do
    echo "Table verification attempt $i of 3..."
    if bundle exec rails runner "puts 'Table exists: ' + GoodMemory.connection.table_exists?('good_memories').to_s"; then
        echo "Table verification successful!"
        break
    else
        echo "Table verification attempt $i failed"
        if [ $i -eq 3 ]; then
            echo "All table verification attempts failed. Exiting."
            exit 1
        fi
        sleep 5
    fi
done

# Skip seeding in production
echo "Skipping seed data (production environment)"

echo "Build completed successfully!" 