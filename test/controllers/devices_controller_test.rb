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
        get :index
      end
      should_render_with_layout "admin"
    end
  end
end
