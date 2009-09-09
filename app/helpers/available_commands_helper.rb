module AvailableCommandsHelper
  def partial_for(available_command)
    if available_command.params.size > 0
      '/fast_commands/available_commands/text_field'
    else
      '/fast_commands/available_commands/check_box'
    end
  end
  
  def param_label(param)
    param.label || param.name.titleize
  end
end
