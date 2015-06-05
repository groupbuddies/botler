server '10.6.6.6',
  user: 'vagrant',
  roles: %w{web app db},
  primary: true,
  ssh_options: {
    keys: %w(~/.vagrant.d/insecure_private_key),
    forward_agent: true,
  }

