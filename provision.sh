#!/bin/bash

# Updating
sudo apt-get --yes update

# Install curl
sudo apt-get --yes install curl

# Install git
sudo apt-get --yes install git

# Install qt, needed by capybara gem
sudo apt-get --yes install libqt4-dev

# PostgreSQL
## Update locale
sudo locale-gen en_US.UTF-8
sudo /usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
sudo sed 's/en_US/en_US.UTF-8/' < /etc/default/locale
## Install postgresql
sudo apt-get --yes install postgresql libpq-dev
## Create user
sudo -u postgres createuser -s -d vagrant

# Ruby
## Install rvm
curl -sSL https://get.rvm.io | bash
source /usr/local/rvm/scripts/rvm
## Install requirements
rvm requirements
## Install ruby
rvm --quiet-curl install 2.2
rvm use 2.2 --default
## Install bundler
gem install bundler

# Install nodejs
sudo apt-get --yes install nodejs

# Install nginx
sudo apt-get --yes install nginx

