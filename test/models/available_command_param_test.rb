require 'test_helper'

class AvailableCommandParamTest < ActiveSupport::TestCase
  context "AvailableCommand" do
    should_belong_to :available_command
  end
end
