class AvailableCommands
  include Validatable
  attr_accessor :commands, :id

  def initialize(commands = nil)
    self.commands = commands
  end

  def each(&block)
    commands.each(&block)
  end

  def find(id)
    commands.find { |command| command.id == id.to_i }
  end
  
  
  def create_commands_for_devices(device_ids, available_commands)
    return false if device_ids.blank?
    scrubbed_commands = scrub(available_commands).map do |command_id, command_params|
      commands.find(command_id).build_command_strings_for_devices(device_ids,
        command_params)
    end
    return false if scrubbed_commands.empty?
    Command.create scrubbed_commands.flatten
  end

  def parse_errors(params)
    params.each do |command_id, command_params|
      available_command, empty_param_ids = find_missing_params(command_id, command_params)
      add_errors available_command, empty_param_ids
    end
  end

  def scrub(available_commands)
    available_commands.reject do |command_id, command_params|
      if command_params.is_a?(Hash)
        next true unless command_params.has_key?(:params_attributes)
        next command_params[:params_attributes].values.any?(&:blank?)
      end
      next false
    end
  end

  private
  def find_missing_params(command_id, command_params)
    return unless command_params[:params_attributes]

    available_command = nil
    empty_param_ids = []
    command_params[:params_attributes].each do |param_id, param_value|
      if param_value.present?
        available_command ||= find(command_id)
        available_command.params.detect { |p| p.id == param_id.to_i }.value = param_value
      else
        empty_param_ids << param_id
      end
    end
    return available_command, empty_param_ids
  end
  
  def add_errors(available_command, empty_param_ids)
    return unless available_command.present? && empty_param_ids.any?
    empty_param_names = empty_param_ids.map do |param_id|
      available_command.params.detect { |p| p.id == param_id.to_i }.title
    end
    errors.add(:base, "#{available_command.name} missing #{empty_param_names.to_sentence}")
  end
  
end