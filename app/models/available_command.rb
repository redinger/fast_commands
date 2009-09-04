class AvailableCommand < ActiveRecord::Base
  has_many :available_command_params, :dependent => :destroy
  def self.create_commands_for_devices(available_command_ids, device_ids)
    available_command_ids.each do |command_id, command_value|
      AvailableCommand.find(command_id).create_for_devices(device_ids)
    end
  end
  
  def create_for_devices(device_ids = [])
    commands = device_ids.map {|device_id| {:device_id => device_id, :command => value}}
    Command.create commands
  end
end