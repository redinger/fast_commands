require 'test_helper'

class DevicesTest < ActiveSupport::TestCase
  should "initialize with devices" do
    assert_equal :some_devices, Devices.new(:some_devices).devices
  end

  should "delegate each to devices" do
    device = OpenStruct.new(:called => false)
    devices = Devices.new([device])
    devices.each {|d| d.called = true}
    assert device.called
  end
end
