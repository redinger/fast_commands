require 'test_helper'

class CommandsControllerTest < ActionController::TestCase
  tests FastCommands::CommandsController
  
  context "On GET to index" do
    context "when signed out" do
      setup { get :index }
      should_deny_access
    end
    
    context "when signed in as admin" do
      setup do
        session[:is_super_admin] = true
        
        @device = Factory.build(:device, :id => '1')
        mock(Device).find('1') { @device }
        @commands = [ Factory.build(:command, :device => @device) ]
        mock(@device).commands { @commands }
        
        get :index, :device_id => @device.id
      end
      should_render_with_layout "admin"
      should_assign_to(:commands) { @commands }
    end
  end
end
