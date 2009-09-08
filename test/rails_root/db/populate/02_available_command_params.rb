available_command = AvailableCommand.find_by_name('Configure Direction Change Reporting')
AvailableCommandParam.with_options :available_command_id => available_command.id do |command|
  command.create_or_update(:id => 1, :name => 'degree_of_direction_change')
end
