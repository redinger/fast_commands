require 'test_helper'

class CommandsControllerTest < ActionController::TestCase
  tests FastCommands::CommandsController
  
  context "On GET to index" do
    context "when signed out" do
      setup { get :index }
      should_deny_access
    end
    
    context "signed in as admin" do
      setup do
        session[:is_super_admin] = true
        @device = Factory.build(:device, :id => '1')
        @commands = [ Factory.build(:command, :device => @device) ]
      end

      context "passing device_id" do
        setup do
          stub(Device).find('1') { @device }
          stub(@device).commands { @commands }
          get :index, :device_id => @device.id
        end
        should_assign_to(:commands) { @commands }
      end
      
      context "not passing device_id" do
        setup do
          stub(Command).all { @commands }
          get :index
        end

        should_render_with_layout "admin"
        should_assign_to(:commands) { @commands }
      end
    end
  end
  
  context "on POST to create" do
    context "when signed out" do
      setup { post :create }
      should_deny_access
    end
    

    context "signed in as admin" do
      setup do
        session[:is_super_admin] = true
        stub(AvailableCommand).create_commands_for_devices
      end
      
      context "missing parameter" do
        should_eventually "keep parameters around when redirecting on failed post"
        context "available_commands" do
          setup {post :create, :device_ids => ['201']}
          should_redirect_to("devices index") { nm_5500_devices_url }
          should_set_the_flash_to /commands/
        end

        context "device_ids" do
          setup {post :create, :available_commands => {'101' => "1"}}
          should_redirect_to("devices index") { nm_5500_devices_url }
          should_set_the_flash_to /devices/
        end

      end
      context "posting" do
        setup do
          post :create, :available_commands => {'101' => "1"}, :device_ids => ['201']
        end
      
        should_redirect_to("nm-5500 commands index") { nm_5500_commands_url }
        should "create commands" do
          assert_received(AvailableCommand) {|command| command.create_commands_for_devices({'101'=>'1'}, ['201'])}
        end
      end
    end
  end
end
