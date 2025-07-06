#!/usr/bin/env bash
# Database connection test script

echo "Testing database connection..."

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL environment variable is not set"
    exit 1
fi

echo "DATABASE_URL is configured"

# Test database connection
echo "Testing database connection..."
bundle exec rails runner "
begin
  ActiveRecord::Base.connection.execute('SELECT 1')
  puts '✓ Database connection successful'
rescue => e
  puts '✗ Database connection failed: ' + e.message
  exit 1
end
"

# Check if table exists
echo "Checking if good_memories table exists..."
bundle exec rails runner "
begin
  if GoodMemory.connection.table_exists?('good_memories')
    puts '✓ good_memories table exists'
  else
    puts '✗ good_memories table does not exist'
    puts 'Running migrations...'
    Rake::Task['db:migrate'].invoke
    if GoodMemory.connection.table_exists?('good_memories')
      puts '✓ good_memories table created successfully'
    else
      puts '✗ Failed to create good_memories table'
      exit 1
    end
  end
rescue => e
  puts '✗ Error checking table: ' + e.message
  exit 1
end
"

echo "Database test completed successfully!" 