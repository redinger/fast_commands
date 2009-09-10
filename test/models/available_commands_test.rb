require 'test_helper'

class AvailableCommandsTest < ActiveSupport::TestCase
  should "initialize with available commands" do
    assert_equal :some_commands, AvailableCommands.new(:some_commands).commands
  end

  should "delegate each to commands" do
    command = OpenStruct.new(:called => false)
    commands = AvailableCommands.new([command])
    commands.each {|d| d.called = true}
    assert command.called
  end
  
  should "find command" do
    find_me = Factory.build(:available_command, :id => '201')
    not_me = Factory.build(:available_command, :id => '101')
    commands = AvailableCommands.new([find_me, not_me])
    assert_equal find_me, commands.find('201')
  end

  context "parse errors" do
    should "not find any when no param attributes needed" do
      available_commands = AvailableCommands.new
      available_commands.parse_errors({'1' => '2'})
      assert available_commands.errors.empty?
    end

    should "not find any if all param attributes provided" do
      param = Factory.build(:available_command_param, :id => '2', :value => 'param_value')
      command = Factory.build(:available_command, :id => '1', :params => [param])
      available_commands = AvailableCommands.new([command])
      available_commands.parse_errors({'1' => {:params_attributes => {'2' => 'param'}}})
      assert available_commands.errors.empty?
    end

    should "not find any if no param attributes provided" do
      available_commands = AvailableCommands.new
      available_commands.parse_errors({'1' => {:params_attributes => {'2' => ''}}})
      assert available_commands.errors.empty?
    end
    
    should "add error to base with param name when at least one param missing" do
      param = Factory.build(:available_command_param, :id => '2')
      missing_param = Factory.build(:available_command_param, :id => '3', :name => 'not there')
      command = Factory.build(:available_command, :id => '1',
        :params => [param, missing_param],
        :name => 'Command')
      available_commands = AvailableCommands.new([command])
      available_commands.parse_errors({'1' => {:params_attributes => {'2' => 'param', '3' => ''}}})
      assert_match /Command missing Not There/, available_commands.errors.on(:base)
    end
  end
end