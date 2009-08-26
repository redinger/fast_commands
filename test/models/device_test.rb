require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  context "named scopes" do
    should "return nm5500_devices" do
      nm5500 = Factory(:device, :gateway_name => FastCommands::Device::NM5500_GATEWAY_NAME)
      Factory(:device, :gateway_name => 'not-xirgo-wired')
      
      assert_equal [nm5500], Device.nm5500_devices
    end
  end
end
