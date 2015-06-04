lock '3.2.1'

set :application, 'gb-botler'
set :repo_url, 'git@github.com:groupbuddies/botler.git'
set :branch, (ENV['DEPLOY_BRANCH'] || :master)

set :stage, :production
set :rails_env, :production

set :format, :pretty
set :log_level, :debug
set :pty, true

set :rvm_ruby_version, '2.2.0'

set :linked_files, %w{.env}
set :linked_dirs, %w{log public/system public/uploads}

set :bundle_without, %w(development test deploy).join(' ')
set :keep_releases, 3

namespace :deploy do
  desc 'Restart Botler'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
end
