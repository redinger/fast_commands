require 'test_helper'

class DevicesControllerTest < ActionController::TestCase
  tests FastCommands::DevicesController
  
  context "On GET to index" do
    context "when signed out" do
      setup { get :index }
      should_deny_access
    end
    
    context "when signed in as admin" do
      setup do
        session[:is_super_admin] = true
        @devices = [Factory.build(:device)]
        stub(Device).nm5500_devices { @devices }
        @available_commands = [Factory.build(:available_command)]
        stub(AvailableCommand).all { @available_commands }
        get :index
      end
      should_render_with_layout "admin"
      should_assign_to(:devices) { @devices }
      should_assign_to(:available_commands) { @availalbe_commands }
    end
  end
end
