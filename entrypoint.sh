#!/bin/bash

# Set global variable
RUN_MIGRATIONS=${RUN_MIGRATIONS:-false}

if [ "$RUN_MIGRATIONS" = true ]; then
  # Run migrations
  echo "RUN_MIGRATIONS set to true, running migrations"
  npx medusa migrations run
  yarn start
else
  echo "RUN_MIGRATIONS not set to true, skipping migrations"

  yarn start
fi
