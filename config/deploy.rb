# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "on_school"

set :rails_env,                  "production"

set :use_sudo,                   false
set :rvm_type,                   :user

set :migration_role,             :web
set :conditionally_migrate,      true
set :assets_roles,               %w{web}
set :keep_releases,              10

set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log keys tmp/pids tmp/cache tmp/sockets tmp/uploads tmp/binlog vendor/bundle public/system public/uploads public/assets}

set :exclude_dir, %w{public/uploads log tmp vendor public/assets}

#after 'deploy:publishing', 'deploy:restart'
after "deploy", "deploy:cleanup"

