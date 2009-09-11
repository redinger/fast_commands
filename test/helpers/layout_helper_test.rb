require 'test_helper'

class FastCommands::LayoutHelperTest < ActionView::TestCase
  should "capture javascript" do
    javascript(:java, :script)
    assert_match '<script src="/javascripts/java.js" type="text/javascript"></script>', @content_for_head
    assert_match '<script src="/javascripts/script.js" type="text/javascript"></script>', @content_for_head
  end
end