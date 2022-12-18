namespace :pumactl do
  desc 'Execute pumactl restart for favoreyo'
  task :restart do
    on release_roles(:app) do
      within release_path do
        execute "cd #{release_path} && bundle exec pumactl restart"
      end
    end
  end
end
