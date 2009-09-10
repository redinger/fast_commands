require 'fast_commands'

config.gem 'binarylogic-searchlogic',
  :lib => 'searchlogic',
  :source => 'http://gems.github.com',
  :version => '>= 2.3.3'

config.gem 'ffmike-db_populate',
  :lib => 'create_or_update',
  :source => 'http://gems.github.com',
  :version => '>= 0.2.3'

config.gem 'mislav-will_paginate',
  :lib => 'will_paginate',
  :source => 'http://gems.github.com',
  :version => '>= 2.3.11'

config.gem 'jnunemaker-validatable',
  :lib => 'validatable',
  :source => 'http://gems.github.com',
  :version => '>= 1.7.2'

config.to_prepare do
  ApplicationController.helper(AvailableCommandsHelper)
  ApplicationController.helper(DevicesHelper)
end