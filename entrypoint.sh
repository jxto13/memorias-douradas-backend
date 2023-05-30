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

  # Change directory to custom-plugins/medusa-plugin-nodemailer
  cd custom-plugins/medusa-plugin-nodemailer
  
  # Run yarn install in the custom-plugins/medusa-plugin-nodemailer directory
  yarn install
  
  # Run yarn link in the custom-plugins/medusa-plugin-nodemailer directory
  yarn link
  
  # Run yarn watch in the custom-plugins/medusa-plugin-nodemailer directory (optional)
  yarn watch &
  
  # Go back to the previous directory
  cd -
  
  # Run yarn link medusa-plugin-nodemailer in the previous directory
  yarn link medusa-plugin-nodemailer

  yarn start
fi
