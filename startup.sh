#!/bin/bash
# PATH=/home/pi/.nvm/versions/node/v19.4.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
# HOME=/home/pi
# pm2_path=$(which pm2)
# export PATH=$PATH:$pm2_path

version=1.0
stored_version=$(cat ./.update/version 2>/dev/null)

run_script() {
  sudo mkdir test_auto_updates
}

if [ -z "$stored_version" ]; then
  echo "Creating version file" | tee -a ./.update/logs.txt
  touch ./.update/version || { echo "Error: Failed to create version file" | tee -a ./.update/logs.txt; exit 1; }
  echo "Setting permissions on version file" | tee -a ./.update/logs.txt
  chmod 766 version || { echo "Error: Failed to set permissions on version file" | tee -a ./.update/logs.txt; exit 1; }
  echo "Writing version to version file" | tee -a ./.update/logs.txt
  echo "$version" > ./.update/version || { echo "Error: Failed to write version to version file" | tee -a ./.update/logs.txt; exit 1; }
  echo "Running script" | tee -a ./.update/logs.txt
  run_script || { echo "Error: Failed to run script" | tee -a ./.update/logs.txt; exit 1; }
else
  if [ "$version" \> "$stored_version" ]; then
    echo "Updating version in version file" | tee -a ./.update/logs.txt
    echo "$version" > ./.update/version || { echo "Error: Failed to update version in version file" | tee -a ./.update/logs.txt; exit 1; }
    echo "Running script" | tee -a ./.update/logs.txt
    run_script || { echo "Error: Failed to run script" | tee -a ./.update/logs.txt; exit 1; }
  else
    echo "Skipping script because stored version ($stored_version) is greater than or equal to current version ($version)" | tee -a ./.update/logs.txt
  fi
fi
