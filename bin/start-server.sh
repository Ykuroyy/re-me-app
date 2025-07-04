#!/usr/bin/env bash
# Production server startup script for Render

echo "Starting production server..."

# Check if we're in production
if [ "$RAILS_ENV" != "production" ]; then
    echo "WARNING: Not in production environment"
fi

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL environment variable is not set"
    exit 1
fi

# Check if PORT is set
if [ -z "$PORT" ]; then
    echo "WARNING: PORT environment variable is not set, using default 3000"
    export PORT=3000
fi

echo "Starting Puma server on port $PORT..."

# Start the server
bundle exec puma -C config/puma.rb 