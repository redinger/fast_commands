require 'test_helper'

class FastCommands::FormTagHelperTest < ActionView::TestCase
  context "check box for" do
    should "return checked devices" do
      device = Factory.build(:device, :id => "1")
      devices = Devices.new([device])
      assert_equal '<input id="device_1" name="device_ids[]" type="checkbox" value="1" />',
        check_box_for_bulk_action('device_ids[]', devices, device)
    end
    
    should "return unchecked devices" do
      checked_device = Factory.build(:device, :id => "1")
      device = Factory.build(:device, :id => "2")
      devices = Devices.new([device, checked_device])
      devices.checked = ["1"]
      assert_equal '<input id="device_2" name="device_ids[]" type="checkbox" value="2" />',
        check_box_for_bulk_action('device_ids[]', devices, device)
      assert_equal '<input checked="checked" id="device_1" name="device_ids[]" type="checkbox" value="1" />',
        check_box_for_bulk_action('device_ids[]', devices, checked_device)
    end
  end
end
