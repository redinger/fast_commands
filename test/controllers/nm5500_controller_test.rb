require 'test_helper'

class Nm5500sControllerTest < ActionController::TestCase
  tests FastCommands::Nm5500sController

  context "On GET to show" do
    context "when signed out" do
      setup { get :show }
      should_deny_access
    end
    
    context "when signed in as admin" do
      setup do
        stub(Device).nm5500_devices {stub!.count {1}}
        session[:is_super_admin] = true
        get :show
      end
      should_render_with_layout "admin"
      should_assign_to(:total_devices) { 1 }
    end
  end
end
