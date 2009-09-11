module FastCommands::DevicesHelper
  def check_box_for(devices, device)
    checked = !devices.checked.nil? && devices.checked.include?(device.id.to_s)
    check_box_tag 'device_ids[]', device.id, checked, :id => dom_id(device)
  end
end
