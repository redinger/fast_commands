require 'fast_commands'

config.gem 'ffmike-db_populate',
    :lib => 'create_or_update',
    :source => 'http://gems.github.com',
    :version => '>= 0.2.3'
    
config.to_prepare do
  ApplicationController.helper(AvailableCommandsHelper)
end
    