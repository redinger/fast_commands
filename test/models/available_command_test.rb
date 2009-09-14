require 'test_helper'

class AvailableCommandTest < ActiveSupport::TestCase
  context "AvailableCommand" do
    should_have_many :params, :dependent => :destroy

    should "build_command_strings_for_devices" do
      assert true, 'tests reside in AvailableCommandsTest'
    end
  end
end
