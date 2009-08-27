begin
  require 'metric_fu'
rescue LoadError => e
  # Yep, swallowing that exception.
end

MetricFu::Configuration.run do |config|
  config.rcov[:rcov_opts] << "--include-file app/"
 end