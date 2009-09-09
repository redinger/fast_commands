available_command = AvailableCommand.find_by_name('Configure Direction Change Reporting')
AvailableCommandParam.with_options :available_command_id => available_command.id do |command|
  command.create_or_update(:id => 1, :name => 'degree_of_direction_change')
end

available_command = AvailableCommand.find_by_name('Configure Server Info')
AvailableCommandParam.with_options :available_command_id => available_command.id do |command|
  command.create_or_update(:id => 2, :name => 'port')
  command.create_or_update(:id => 3, :name => 'ip', :label => 'IP Address')
  command.create_or_update(:id => 4, :name => 'transport_type')
end
