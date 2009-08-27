require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
class FastCommandsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.insert_into 'app/models/device.rb', 'include FastCommands::Device'
      
      m.directory File.join("test", "factories")
      m.file "factories.rb", "test/factories/fast_commands.rb"
      
      unless ActiveRecord::Base.connection.table_exists?(:commands)
        m.migration_template 'migrations/create_commands.rb',
                             'db/migrate',
                             :migration_file_name => 'fast_commands_create_commands'
      end
    end
  end
end