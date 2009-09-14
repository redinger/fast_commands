class AvailableCommand < ActiveRecord::Base
  has_many :params, :class_name => 'AvailableCommandParam',
    :dependent => :destroy

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