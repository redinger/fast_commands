class AvailableCommand < ActiveRecord::Base
  has_many :params, :class_name => 'AvailableCommandParam',
    :dependent => :destroy

  def self.create_commands_for_devices(device_ids, available_commands)
    commands = scrub(available_commands).map do |command_id, command_params|
      AvailableCommand.find(command_id).build_command_strings_for_devices(device_ids,
        command_params)
    end
    return false if commands.empty?
    Command.create commands.flatten
  end

  def self.scrub(available_commands)
    available_commands.reject do |command_id, command_params|
      if command_params.is_a?(Hash)
        next true unless command_params.has_key?(:params_attributes)
        next command_params[:params_attributes].values.all?(&:blank?)
      end
      next false
    end
  end
  
  def build_command_strings_for_devices(device_ids, command_params)
    device_ids.map do |device_id|
      {:device_id => device_id, :command => build_command_string(command_params)}
    end
  end
  
  private
  def build_command_string(command_params)
    returning value do |command_string|
      if command_params.is_a?(Hash)
        params.each do |param|
          command_string.gsub!("\#{#{param.name}}", 
            command_params[:params_attributes][param.id.to_s])
        end
      end
    end
  end
end