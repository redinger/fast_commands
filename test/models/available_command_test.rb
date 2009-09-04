require 'test_helper'

class AvailableCommandTest < ActiveSupport::TestCase
  context "AvailableCommand" do
    should "create commands for devices" do
      available_command = Factory.build(:available_command, :id => 1)
      stub(AvailableCommand).find('1') {available_command}
      mock(available_command).create_for_devices('101')
      AvailableCommand.create_commands_for_devices({'1' => '1'}, '101')
    end
    
    should "create for devices" do
      available_command = Factory.build(:available_command, :id => 1, :value => '+XT:AAAA')
      mock(Command).create([{:device_id => '101', :command  => '+XT:AAAA'}])
      available_command.create_for_devices('101')
    end
  end
end
