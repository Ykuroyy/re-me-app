#!/usr/bin/env bash
# Production database reset script
# WARNING: This will delete all data in production!

echo "WARNING: This will reset the production database and delete all data!"
echo "Are you sure you want to continue? (y/N)"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Resetting production database..."
    
    # Check if DATABASE_URL is set
    if [ -z "$DATABASE_URL" ]; then
        echo "ERROR: DATABASE_URL environment variable is not set"
        exit 1
    fi
    
    # Drop and recreate database
    echo "Dropping database..."
    bundle exec rake db:drop 2>/dev/null || echo "Database drop failed (may not exist)"
    
    echo "Creating database..."
    bundle exec rake db:create
    
    echo "Running migrations..."
    bundle exec rake db:migrate
    
    echo "Checking migration status..."
    bundle exec rake db:migrate:status
    
    echo "Verifying table exists..."
    bundle exec rails runner "puts 'Table exists: ' + GoodMemory.connection.table_exists?('good_memories').to_s"
    
    echo "Production database reset completed!"
else
    echo "Database reset cancelled."
fi 