class Rails::Generator::Commands::Create
  def migration_template_with_fast_commands(relative_source, relative_destination, template_options = {})
    migration_directory relative_destination if @migration_directory.nil?

    time = Time.now.utc.strftime("%Y%m%d%H%M%S")
    if Dir.glob("#{@migration_directory}/[0-9]*_*.rb").grep(/#{time}_.*.rb$/).any?
      sleep 1
    end
    
    migration_template_without_fast_commands relative_source, relative_destination, template_options
  end
  
  alias_method_chain :migration_template, :fast_commands
end