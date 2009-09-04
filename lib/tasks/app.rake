namespace :app do
  desc 'Resets migrations and loads fixtures and seed data'
  task :setup do
    Rake::Task['db:populate'].invoke
  end
end
