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
    
    should "add error to base when no commands sent" do
      available_commands = AvailableCommands.new
      available_commands.parse_errors({'1' => {:params_attributes => {'2' => ''}}})
      assert_match /No commands specified/, available_commands.errors.on(:base)
    end
    
    should "add checked commands" do
      available_commands = AvailableCommands.new
      available_commands.parse_errors({'1' => '1'})
      assert_equal ['1'], available_commands.checked
    end
  end

  context "create_command_for_device" do
    setup do
      @commands = [Factory.build(:available_command, :id => '1',
        :value => '+XT:AAAA')]
      stub(@commands).find { @commands.first}
      @available_commands = AvailableCommands.new @commands
    end

    should "create for devices with no params" do
      mock(Command).create([{:device_id => '101', :command  => '+XT:AAAA'}])
      @available_commands.create_commands_for_devices('101', {'1' => '1'})
    end

    should "return false when no device ids provided" do
      assert !@available_commands.create_commands_for_devices(nil, {'1' => '1'})
    end

    should "parse errors when no device ids provided" do
      mock(@available_commands).parse_errors('201' => '1')
      @available_commands.create_commands_for_devices(nil, {'201' => '1'})
    end

    should "create for devices with params" do
      available_command_param = Factory.build(:available_command_param,
        :id => 201, :name => 'param_1')
      @commands.first.value = '+XT:BBBB,param'
      @commands.first.params = [available_command_param]

      mock(Command).create([{:device_id => '101',
        :command  => '+XT:BBBB,param'}])
      @available_commands.create_commands_for_devices('101',
        {'1' => {:params_attributes => {'201' => 'param'}}})
    end

    should "return false if all commands are scrubbed" do
      assert !@available_commands.create_commands_for_devices('101',
        {'1' => { :params_attributes => { '2' => '' }}})
    end
    
    should "add to errors when all commands are scrubbed" do
      mock(@available_commands).parse_errors({"1"=>{:params_attributes=>{"2"=>""}}})
      @available_commands.create_commands_for_devices('101', {'1' => { :params_attributes => { '2' => '' }}})
    end
  end

  context "scrubbing params" do
    setup do
      @available_commands = AvailableCommands.new
    end

    should "not scrub a command with no params" do
      assert_equal({'1' => '1'}, @available_commands.scrub('1'=>'1'))
    end
    
    should "not scrub a command with valid params" do
      command = {'1' => { :params_attributes => { '2' => 'param' }}}
      assert_equal(command, @available_commands.scrub(command))
    end
    
    should "scrub command with invalid params" do
      command = {'1' => { :params_attributes => { '2' => '' }}}
      assert_equal({}, @available_commands.scrub(command))        
    end

    should "scrub command with invalid and valid params" do
      command = {'1' => { :params_attributes => { '2' => '', '3' => 'param' }}}
      assert_equal({}, @available_commands.scrub(command))        
    end
  end
end