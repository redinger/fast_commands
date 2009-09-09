require 'test_helper'

class AvailableCommandsHelperTest < ActionView::TestCase
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
  
  context "param label" do
    should "return label when present" do
      assert_equal 'foo_bar',
        param_label(Factory.build(:available_command_param, :label => 'foo_bar'))
    end
    
    should "return titleized name when no label" do
      assert_equal 'Foo Bar',
        param_label(Factory.build(:available_command_param, :name => 'foo_bar'))      
    end
  end
end
