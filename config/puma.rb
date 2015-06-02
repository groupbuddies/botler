workers (ENV['PUMA_WORKERS'] || 1).to_i
threads (ENV['MIN_THREADS'] || 1).to_i, (ENV['MAX_THREADS'] || 16).to_i

preload_app!

rackup DefaultRackup

port ENV['PORT'] || 3000
environment ENV['RAILS_ENV'] || 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end

