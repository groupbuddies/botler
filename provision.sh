#!/bin/bash

# Updating
apt-get --yes update

# Install curl
apt-get --yes install curl

# Install git
apt-get --yes install git

# Install qt, needed by capybara gem
apt-get --yes install libqt4-dev

# PostgreSQL
## Update locale
locale-gen en_US.UTF-8
/usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
sed -i 's/en_US/en_US.UTF-8/' /etc/default/locale
## Install postgresql
apt-get --yes install postgresql libpq-dev
## Create user
sudo -u postgres createuser -s -d botler
sudo -u postgres createdb botler
sed -i 's/# TYPE  DATABASE        USER            ADDRESS                 METHOD/# TYPE  DATABASE        USER            ADDRESS                 METHOD\nlocal   botler          botler                                  trust/' /etc/postgresql/9.1/main/pg_hba.conf
service postgresql restart

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
apt-get --yes install nodejs

# Install nginx
apt-get --yes install nginx

