require 'test_helper'

class FastCommands::AvailableCommandsHelperTest < ActionView::TestCase
  context "partial for" do
    should "return check box partial" do
      assert_equal '/fast_commands/available_commands/check_box',
        partial_for(Factory.build(:available_command))
    end
    
    should "return text field partial" do
      assert_equal '/fast_commands/available_commands/text_field', 
        partial_for(Factory.build(:available_command, 
          :params => [Factory.build(:available_command_param)]))      
    end
  end
end
