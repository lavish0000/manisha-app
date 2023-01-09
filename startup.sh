#!/bin/bash

# Set the version number
version=1.1

# Check if the version is already stored in the system
stored_version=$(cat version 2>/dev/null)

run_script() {
  # Run the rest of the script
  sudo mkdir yo_running_no
}

if [ -z "$stored_version" ]; then
  # If the version is not stored, store it and run the script
  sudo echo "$version" > version
  run_script
else
  # If the version is already stored, compare it to the current version
  if [ "$version" \> "$stored_version" ]; then
    # If the current version is greater than the stored version, update the stored version and run the script
    sudo echo "$version" > version
    run_script
  else
    # If the stored version is greater than or equal to the current version, skip running the script
    echo "Skipping script because stored version ($stored_version) is greater than or equal to current version ($version)"
  fi
fi
