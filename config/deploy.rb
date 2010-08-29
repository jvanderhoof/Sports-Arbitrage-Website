set :application, "bestbetfinder"
set :user, 'deploy'

set :repository,  "http://subversion.assembla.com/svn/#{application}/website/trunk"
set :svn_username, "jvanderhoof"
set :svn_password, "14gotten"

set :deploy_to, "/home/deploy/rails/#{application}.com"
#set :deploy_to, "/var/www/apps/#{application}"
#set :port, 30300

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "174.143.175.241"
role :web, "174.143.175.241"
role :db,  "174.143.175.241", :primary => true

set :deploy_via, :copy
set :synchronous_connect, true

#set :runner, user
=begin
after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
=end