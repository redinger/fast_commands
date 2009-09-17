available_command = AvailableCommand.find_by_name('Configure Direction Change Reporting')
AvailableCommandParam.with_options :available_command_id => available_command.id do |command|
  command.create_or_update(:id => 1, :name => 'degree_of_direction_change',
    :hint => '0 = disable, between 1 and 180, increments of 5 degrees.')
end

available_command = AvailableCommand.find_by_name('Configure Server Info')
AvailableCommandParam.with_options :available_command_id => available_command.id do |command|
  command.create_or_update(:id => 2, :name => 'port', :hint => 'between 0 and 65000')
  command.create_or_update(:id => 3, :name => 'ip', :label => 'IP Address',
    :hint => 'in the form 111.222.333.444')
  command.create_or_update(:id => 4, :name => 'transport_type',
    :hint => '1 or 0 where 1 = TCP, 2 = UDP')
end