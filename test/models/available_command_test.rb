require 'test_helper'

class AvailableCommandTest < ActiveSupport::TestCase
  context "AvailableCommand" do
    should_have_many :params, :dependent => :destroy

    should "create commands for devices with no params" do
      available_command = Factory.build(:available_command, :id => 1,
        :value => '+XT:AAAA')
      stub(AvailableCommand).find('1') {available_command}
      mock(Command).create([{:device_id => '101', :command  => '+XT:AAAA'}])
      AvailableCommand.create_commands_for_devices('101', {'1' => '1'})
    end

    should "create commands for devices with params" do
      available_command_param = Factory.build(:available_command_param,
        :id => 201, :name => 'param_1')
      available_command = Factory.build(:available_command, :id => 1,
        :value => '+XT:BBBB,#{param_1}',
        :params => [available_command_param])
      stub(AvailableCommand).find('1') {available_command}
      mock(Command).create([{:device_id => '101',
        :command  => '+XT:BBBB,param'}])
      AvailableCommand.create_commands_for_devices('101',
        {'1' => {:params_attributes => {'201' => 'param'}}})
    end

    should "return false if all commands are scrubbed" do
      assert !AvailableCommand.create_commands_for_devices('101',
        {'1' => { :params_attributes => { '2' => '' }}})
    end

    context "scrubbing params" do
      should "not scrub a command with no params" do
        assert_equal({'1' => '1'}, AvailableCommand.scrub('1'=>'1'))
      end
      
      should "not scrub a command with valid params" do
        command = {'1' => { :params_attributes => { '2' => 'param' }}}
        assert_equal(command, AvailableCommand.scrub(command))
      end
      
      should "scrub command with invalid params" do
        command = {'1' => { :params_attributes => { '2' => '' }}}
        assert_equal({}, AvailableCommand.scrub(command))        
      end
    end
  end
end
