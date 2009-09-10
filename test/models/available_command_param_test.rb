require 'test_helper'

class AvailableCommandParamTest < ActiveSupport::TestCase
  context "AvailableCommand" do
    should_belong_to :available_command
  end
  
  
  context "title" do
    should "return label when present" do
      assert_equal 'foo_bar',
        Factory.build(:available_command_param, :label => 'foo_bar').title
    end
    
    should "return titleized name when no label" do
      assert_equal 'Foo Bar',
        Factory.build(:available_command_param, :name => 'foo_bar').title
    end
  end
end
