#!/bin/bash

# Exit script if any command fails
set -e

# Function to handle errors
error_handler() {
  echo "Error: An error occurred at line $1"
  exit 1
}

# Trap errors
trap 'error_handler $LINENO' ERR

# Check if Node.js is installed
if ! command -v node &> /dev/null
then
    # Log message
    echo "Installing Node.js..."

    # Check if nvm is installed
    if ! command -v nvm &> /dev/null
    then
        # Log message
        echo "Installing nvm..."

        # Install nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    fi

    # Load nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install the latest stable version of Node.js using nvm
    nvm install stable
fi

# Update package index files
sudo apt-get update

# Check if Nginx is installed
if ! command -v nginx &> /dev/null
then
    # Log message
    echo "Installing Nginx..."

    # Install Nginx
    sudo apt-get install -y nginx
fi

# Log message
echo "Cloning Node.js server repository..."

# Clone the Node.js server repository
git clone https://github.com/peaqnetwork/peaq-did-raspberry-pi.git

# Navigate to the server directory
cd peaq-did-raspberry-pi

# Log message
echo "Installing dependencies..."

# Install dependencies
npm i

# Log message
echo "Installing PM2..."

# Install PM2
npm install pm2@latest -g

# Log message
echo "Starting server using PM2..."

# Start the server using PM2

pm2 start index.js

# Generate startup script	
pm2 startup	

# Get the startup script	
startup_script=$(pm2 startup)	

# Execute the startup script	
eval "$startup_script"

# Save the PM2 process list	
pm2 save

# Log success message	
echo "Script completed successfully!"
