# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'chucky'
set :repo_url, 'git@github.com:matiasrenta/chucky.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deployer/railsapps/chucky'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

namespace :deploy do

  namespace :assets do
    Rake::Task['deploy:assets:precompile'].clear_actions
    desc 'Precompile assets locally and upload to servers'
    task :precompile do
      on roles(fetch(:assets_roles)) do
        run_locally do
          execute 'RAILS_ENV=production bundle exec rake assets:precompile'
          #with rails_env: fetch(:rails_env) do
          #  execute 'bin/rake assets:precompile'
          #end
        end
        within release_path do
          with rails_env: fetch(:rails_env) do
            old_manifest_path = "#{shared_path}/public/assets/manifest*"
            execute :rm, old_manifest_path if test "[ -f #{old_manifest_path} ]"
            #upload!('./public/assets/', "#{shared_path}/public/", recursive: true)
            upload!('./public/assets/', "#{shared_path}/public/", recursive: true)
          end
        end
        run_locally { execute 'rm -rf public/assets' }
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
  #    # Here we can do anything such as:
  #    #within release_path do
  #    #  execute :rake, 'cache:clear'
  #    #end
  #  end
  #end

  after :finishing, 'deploy:cleanup'

end
