#!/bin/bash

# Check if Node.js is installed
if ! command -v node &> /dev/null
then
    # Install Node.js
    curl -sL https://deb.nodesource.com/setup_14.x | bash -
    apt-get install -y nodejs
fi

# Check if Nginx is installed
if ! command -v nginx &> /dev/null
then
    # Install Nginx
    apt-get install -y nginx
fi

# Clone the Node.js server repository
git clone https://github.com/peaqnetwork/peaq-did-raspberry-pi.git

# Navigate to the server directory
cd peaq-did-raspberry-pi

# Install dependencies
npm i

# Install PM2
npm install pm2@latest -g

# Start the server using PM2
pm2 start index.js

# Save the PM2 process list
pm2 save

# Generate startup script
pm2 startup

# Get the startup script
startup_script=$(pm2 startup)

# Execute the startup script
eval "$startup_script"
