require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
class FastCommandsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.insert_into 'app/models/device.rb', 'include FastCommands::Device'
    end
  end
end
