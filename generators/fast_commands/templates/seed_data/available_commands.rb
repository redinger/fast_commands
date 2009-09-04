AvailableCommand.with_options :device_type => 'nm-5500' do |command|
  command.create_or_update(:id => 1, :name => 'Query Current Location', :value => '+XT:AAAA,1')
  command.create_or_update(:id => 2, :name => 'Query Vehicle Information (VIN, etc...)', :value => '+XT:BBBB,1')
  command.create_or_update(:id => 3, :name => 'Reboot the Device', :value => '+XT:CCCC')
end
