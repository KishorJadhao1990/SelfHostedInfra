#!/bin/bash
set -e

# Update system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib

# Start and enable PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Verify installation
psql --version
systemctl status postgresql --no-pager