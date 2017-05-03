#!/usr/bin/env bash

# Based on Microsoft guide to install Microsoft PHP Drivers for SQL Server on linux
# https://www.microsoft.com/en-us/download/details.aspx?id=20098

if [ -f /usr/lib/php/20160303/sqlsrv.so ]
then
    echo "Microsoft PHP Drivers for SQL Server already installed."
    exit 0
fi

# Install pre-requisites
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql mssql-tools
sudo apt-get install -y unixodbc-dev

# Install the Microsoft PHP Drivers for SQL Server
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv

# Load the Microsoft PHP Drivers for SQL Server
extensions="
extension=/usr/lib/php/20160303/sqlsrv.so
extension=/usr/lib/php/20160303/pdo_sqlsrv.so
"
sudo echo "$extensions" > "/etc/php/7.1/fpm/php.ini"
sudo echo "$extensions" > "/etc/php/7.1/cli/php.ini"
