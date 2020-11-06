#!/bin/bash
set -e

# avoid PID conflicting issues
if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi
rails db:setup

exec "$@" # will execute the command from docker-compose