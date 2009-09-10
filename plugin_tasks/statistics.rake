RAILS_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(RAILS_ROOT)

STATS_DIRECTORIES = [
  %w(Controllers        app/controllers),
  %w(Helpers            app/helpers), 
  %w(Models             app/models),
  %w(Libraries          lib/),
  %w(APIs               app/apis),
  %w(Functional\ tests  test/controllers),
  %w(Unit\ tests        test/models),
  %w(Units        test/helpers)
].collect { |name, dir| [ name, "#{RAILS_ROOT}/#{dir}" ] }.select { |name, dir| File.directory?(dir) }

desc "Report code statistics (KLOCs, etc) from the application"
task :stats do
  require 'code_statistics'
  CodeStatistics.new(*STATS_DIRECTORIES).to_s
end
