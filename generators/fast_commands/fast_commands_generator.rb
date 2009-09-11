require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/lib/extensions/generator_patch.rb")
class FastCommandsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.insert_into 'app/models/device.rb', 'include FastCommands::Device'

      m.directory File.join('public', 'javascripts', 'fast_commands')
      m.file 'javascripts/commands_new.js', 'public/javascripts/fast_commands/commands_new.js'
      
      m.directory File.join("test", "factories")
      m.file "factories.rb", "test/factories/fast_commands.rb"

      generate_seed_data(m)

      generate_migrations(m)
    end
  end

  private
  def generate_seed_data(record)
    seed_directory 'db/populate'
    record.directory seed_directory
    generate_seed_data_for(record, 'available_commands')
    generate_seed_data_for(record, 'available_command_params')
  end
  
  def generate_seed_data_for(record, seed_file_name)
    raise "Another seed data is already named #{seed_file_name}: #{existing_seeds(seed_file_name).first}" if seed_exists?(seed_file_name)
    record.file "seed_data/#{seed_file_name}.rb", "#{seed_directory}/#{next_seed_string}_#{seed_file_name}.rb"
  end

  def existing_seeds(seed_file_name)
    Dir.glob("#{seed_directory}/[0-9]*_*.rb").grep(/[0-9]+_#{seed_file_name}.rb$/)
  end

  def next_seed_string
    "%.2d" % next_seed_number
  end

  def next_seed_number
    @next_seed_number ||= current_seed_number
    @next_seed_number += 1
  end

  def current_seed_number
    Dir.glob("#{seed_directory}/[0-9]*_*.rb").inject(0) do |max, file_path|
      n = File.basename(file_path).split('_', 2).first.to_i
      if n > max then n else max end
    end
  end

  def seed_exists?(seed_file_name)
    not existing_seeds(seed_file_name).empty?
  end

  def seed_directory(directory = nil)
    @seed_directory ||= directory
  end
  
  def generate_migrations(record)
    unless ActiveRecord::Base.connection.table_exists?(:commands)
      record.migration_template 'migrations/create_commands.rb',
                                'db/migrate',
                                :migration_file_name => 'fast_commands_create_commands'
      puts 'sleeping'
    end

    record.migration_template 'migrations/create_available_commands.rb',
                              'db/migrate',
                              :migration_file_name => 'fast_commands_create_available_commands'
    record.migration_template 'migrations/create_available_command_params.rb',
                              'db/migrate',
                              :migration_file_name => 'fast_commands_create_available_command_params'
  end
end