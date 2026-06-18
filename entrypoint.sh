#!/bin/bash

# Create necessary persistent folders in /data
mkdir -p /data/repo_data
mkdir -p /data/auto_data
mkdir -p /data/checked_data
mkdir -p /data/run_logs

# Remove default ephemeral data directories in the app workspace
rm -rf /app/repo_data
rm -rf /app/auto_data
rm -rf /app/checked_data
rm -rf /app/run_logs
rm -f /app/config.local.json

# Create symbolic links linking /app data folders to the persistent volume at /data
ln -s /data/repo_data /app/repo_data
ln -s /data/auto_data /app/auto_data
ln -s /data/checked_data /app/checked_data
ln -s /data/run_logs /app/run_logs

# Setup configuration link
if [ -f /data/config.local.json ]; then
    ln -s /data/config.local.json /app/config.local.json
else
    echo "{}" > /data/config.local.json
    ln -s /data/config.local.json /app/config.local.json
fi

# Launch Python server
exec python server.py
