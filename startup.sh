#!/bin/bash

# Set the version number
version=1.0

# Check if the version is already stored in the system
stored_version=$(cat version 2>/dev/null)

run_script() {
  # Run the rest of the script
  sudo mkdir yo_running
}

if [ -z "$stored_version" ]; then
  # If the version is not stored, store it and run the script
  if ! sudo touch version; then
    # If the touch command fails, log the error
    echo "Error: Failed to create version file" | tee -a logs.txt
  fi
  if ! sudo chmod 766 version; then
    # If the chmod command fails, log the error
    echo "Error: Failed to set permissions on version file" | tee -a logs.txt
  fi
  if ! sudo echo "$version" > version; then
    # If the echo command fails, log the error
    echo "Error: Failed to write version to version file" | tee -a logs.txt
  fi
  if ! run_script; then
    # If the run_script function fails, log the error
    echo "Error: Failed to run script" | tee -a logs.txt
  fi
else
  # If the version is already stored, compare it to the current version
  if [ "$version" \> "$stored_version" ]; then
    # If the current version is greater than the stored version, update the stored version and run the script
    if ! sudo echo "$version" > version; then
      # If the echo command fails, log the error
      echo "Error: Failed to update version in version file" | tee -a logs.txt
    fi
    if ! run_script; then
      # If the run_script function fails, log the error
      echo "Error: Failed to run script" | tee -a logs.txt
    fi
  else
    # If the stored version is greater than or equal to the current version, skip running the script
    echo "Skipping script because stored version ($stored_version) is greater than or equal to current version ($version)"
  fi	
fi
