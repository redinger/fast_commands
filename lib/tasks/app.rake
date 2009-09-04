namespace :app do
  desc 'Resets migrations and loads fixtures and seed data'
  task :setup do
    'db:populate'
  end
end
