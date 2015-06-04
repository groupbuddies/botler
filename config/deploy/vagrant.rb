set :user, 'vagrant'
server '10.6.6.6', :app, :web, :db, primary: true
set :ssh_options, { forward_agent: true, keys: ['~/.vagrant.d/insecure_private_key'] }
set :deploy_to, '/var/www/gb-botler'
