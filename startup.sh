#!/bin/bash

# Add the path to PM2 to the PATH environment variable
pm2_path=$(which pm2)
export PATH=$PATH:$pm2_path

# Set the version number
version=1.6

# Check if the version is already stored in the system
stored_version=$(cat version 2>/dev/null)

run_script() {
  # Run the rest of the script
  sudo mkdir yo_running_no_5
}

if [ -z "$stored_version" ]; then
  # If the version is not stored, store it and run the script
  echo "Creating version file" | tee -a logs.txt
  if ! sudo touch version; then
    # If the touch command fails, log the error
    echo "Error: Failed to create version file" | tee -a logs.txt
  else
    echo "Successfully created version file" | tee -a logs.txt
  fi
  echo "Setting permissions on version file" | tee -a logs.txt
  if ! sudo chmod 766 version; then
    # If the chmod command fails, log the error
    echo "Error: Failed to set permissions on version file" | tee -a logs.txt
  else
    echo "Successfully set permissions on version file" | tee -a logs.txt
  fi
  echo "Writing version to version file" | tee -a logs.txt
  if ! sudo echo "$version" > version; then
    # If the echo command fails, log the error
    echo "Error: Failed to write version to version file" | tee -a logs.txt
  else
    echo "Successfully written version to version file" | tee -a logs.txt
  fi
  echo "Running script" | tee -a logs.txt
  if ! run_script; then
    # If the run_script function fails, log the error
    echo "Error: Failed to run script" | tee -a logs.txt
  else
    echo "Successfully ran script" | tee -a logs.txt
  fi
  echo "Stopping the PM2 process startup-script" | tee -a logs.txt
  if ! ./test_s.sh; then
    # If the stop command fails, log the error
    echo "Error: Failed to stop the process startup-script" | tee -a logs.txt
  else
    echo "Successfully stopped the process startup-script" | tee -a logs.txt
  fi
else
  # If the version is already stored, compare it to the current version
  if [ "$version" \> "$stored_version" ]; then
    # If the current version is greater than the stored version, update the stored version and run the script
    echo "Updating version in version file" | tee -a logs.txt
    if ! sudo echo "$version" > version; then
      # If the echo command fails, log the error
      echo "Error: Failed to update version in version file" | tee -a logs.txt
    else
      echo "Successfully updated version in version file" | tee -a logs.txt
    fi
    echo "Running script" | tee -a logs.txt
    if ! run_script; then
    # If the run_script function fails, log the error
    echo "Error: Failed to run script" | tee -a logs.txt
    else
      echo "Successfully ran script" | tee -a logs.txt
    fi
    echo "Stopping the PM2 process startup-script" | tee -a logs.txt
  if ! ./test_s.sh; then
    # If the stop command fails, log the error
    echo "Error: Failed to stop the process startup-script" | tee -a logs.txt
  else
    echo "Successfully stopped the process startup-script" | tee -a logs.txt
  fi
  else
    # If the stored version is greater than or equal to the current version, skip running the script
    echo "Skipping script because stored version ($stored_version) is greater than or equal to current version ($version)" | tee -a logs.txt
    
  fi
  
  echo "Stopping the PM2 process startup-script" | tee -a logs.txt
  if ! ./test_s.sh; then
    # If the stop command fails, log the error
    echo "Error: Failed to stop the process startup-script" | tee -a logs.txt
  else
    echo "Successfully stopped the process startup-script" | tee -a logs.txt
  fi
fi
