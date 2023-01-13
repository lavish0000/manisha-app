#!/bin/bash

# PATH=/home/pi/.nvm/versions/node/v19.4.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
# HOME=/home/pi

# Add the path to PM2 to the PATH environment variable
pm2_path=$(which pm2)
export PATH=$PATH:$pm2_path

# Set the version number
version=1.0

# Check if the version is already stored in the system
stored_version=$(cat ./.update/version 2>/dev/null)

run_script() {
  # Run the rest of the script
  sudo mkdir test_auto_updates
}

if [ -z "$stored_version" ]; then
  # If the version is not stored, store it and run the script
  echo "Creating version file" | tee -a ./.update/logs.txt
  if ! sudo touch ./.update/version; then
    # If the touch command fails, log the error
    echo "Error: Failed to create version file" | tee -a ./.update/logs.txt
  else
    echo "Successfully created version file" | tee -a ./.update/logs.txt
  fi
  echo "Setting permissions on version file" | tee -a ./.update/logs.txt
  if ! sudo chmod 766 version; then
    # If the chmod command fails, log the error
    echo "Error: Failed to set permissions on version file" | tee -a ./.update/logs.txt
  else
    echo "Successfully set permissions on version file" | tee -a ./.update/logs.txt
  fi
  echo "Writing version to version file" | tee -a ./.update/logs.txt
  if ! sudo echo "$version" > ./.update/version; then
    # If the echo command fails, log the error
    echo "Error: Failed to write version to version file" | tee -a ./.update/logs.txt
  else
    echo "Successfully written version to version file" | tee -a ./.update/logs.txt
  fi
  echo "Running script" | tee -a ./.update/logs.txt
  if ! run_script; then
    # If the run_script function fails, log the error
    echo "Error: Failed to run script" | tee -a ./.update/logs.txt
  else
    echo "Successfully ran script" | tee -a ./.update/logs.txt
  fi
else
  # If the version is already stored, compare it to the current version
  if [ "$version" \> "$stored_version" ]; then
    # If the current version is greater than the stored version, update the stored version and run the script
    echo "Updating version in version file" | tee -a ./.update/logs.txt
    if ! sudo echo "$version" > ./.update/version; then
      # If the echo command fails, log the error
      echo "Error: Failed to update version in version file" | tee -a ./.update/logs.txt
    else
      echo "Successfully updated version in version file" | tee -a ./.update/logs.txt
    fi
    echo "Running script" | tee -a ./.update/logs.txt
    if ! run_script; then
    # If the run_script function fails, log the error
    echo "Error: Failed to run script" | tee -a ./.update/logs.txt
    else
      echo "Successfully ran script" | tee -a ./.update/logs.txt
    fi
  else
    # If the stored version is greater than or equal to the current version, skip running the script
    echo "Skipping script because stored version ($stored_version) is greater than or equal to current version ($version)" | tee -a ./.update/logs.txt
    
  fi
fi
