require 'test_helper'

class CommandTest < ActiveSupport::TestCase
  context "Command" do
    should "delegate to Device" do
      device = Factory.build(:device, :name => 'name', :imei => 'imei')
      command = Factory.build(:command, :device => device)
      assert_equal device.name, command.device_name
      assert_equal device.imei, command.device_imei
    end
  end
end
