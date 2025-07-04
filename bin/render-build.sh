#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

# データベースのセットアップ
bundle exec rake db:create 2>/dev/null || true
bundle exec rake db:migrate 