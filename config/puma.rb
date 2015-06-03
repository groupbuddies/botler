workers (ENV['PUMA_WORKERS'] || 1).to_i
threads (ENV['MIN_THREADS'] || 1).to_i, (ENV['MAX_THREADS'] || 16).to_i

preload_app!

rackup DefaultRackup

environment ENV['RAILS_ENV'] || 'development'

if %w(production staging).include?(ENV['RAILS_ENV'])
  bind "unix:///var/www/#{ENV['APP_NAME']}/shared/sockets/puma.sock"
else
  port ENV['PORT'] || 3000
end

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end

