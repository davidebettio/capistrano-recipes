require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server "176.34.163.102", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "blog"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "davidebettio.pem")]

set :scm, "git"
set :repository, "git@github.com:davidebettio/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
