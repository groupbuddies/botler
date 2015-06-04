server '10.6.6.6', user: 'vagrant', roles: %w{web app db}, primary: true
set :ssh_options, { forward_agent: true, keys: ['~/.vagrant.d/insecure_private_key'] }
