# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
load 'lib/tasks/metric_fu.rake'

namespace :test do
  Rake::TestTask.new(:basic => ['generator:cleanup',
                                'generator:fast_commands']) do |task|
    task.libs << "lib"
    task.libs << "test"
    task.pattern = "test/**/*_test.rb"
    task.verbose = false
  end
end

namespace :generator do
  desc "Cleans up the test app before running the generator"
  task :cleanup do
    FileUtils.rm_rf('test/rails_root/app/models')
    FileUtils.rm_rf('test/rails_root/test/factories')
    FileList["test/rails_root/db/**/*"].each do |each| 
      FileUtils.rm_rf(each)
    end
    FileUtils.rm_rf("test/rails_root/vendor/plugins/fast_commands")
    FileUtils.mkdir_p("test/rails_root/vendor/plugins")
    FileUtils.cp_r('test/rails_root/templates/models', 'test/rails_root/app/')
    FileUtils.cp_r('test/rails_root/templates/migrate', 'test/rails_root/db/migrate')
    fast_commands_root = File.expand_path(File.dirname(__FILE__))
    system("ln -s #{fast_commands_root} test/rails_root/vendor/plugins/fast_commands")
  end

  desc "Run the fast_commands generator"
  task :fast_commands do
    system "cd test/rails_root && ./script/generate fast_commands && rake db:create:all && rake db:migrate db:test:prepare"
  end
  
end

desc "Run the test suite"
task :default => ['test:basic']
