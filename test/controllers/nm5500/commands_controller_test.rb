require 'test_helper'

class CommandsControllerTest < ActionController::TestCase
  tests FastCommands::CommandsController
  
  context "on GET to index" do
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
        stub(AvailableCommand).create_commands_for_devices {true}
      end
      
      context "missing parameter" do
        should_eventually "alert when no commands have been chosen"
        should_eventually "handle the case where one command is missing params when others are there"
        
        context "device_ids" do
          setup do
            stub(AvailableCommand).create_commands_for_devices {false}
            post :create, :available_commands => {'101' => '1'}
          end
          should_render_template :new
          should "add to errors" do
            assert_match /devices/, assigns['devices'].errors.on(:base)
          end
        end

        context "available_commands that requires param" do
          setup do
            stub(AvailableCommand).create_commands_for_devices {false}
            @devices = [Factory.build(:device)]
            stub(Device).nm5500_devices { @devices }
            @available_commands = AvailableCommands.new([Factory.build(:available_command, :id => '201')])
            stub(@available_commands).parse_errors('201' => '1')
            stub(AvailableCommands).new {@available_commands}
            post :create, :device_ids => ['101'],
              :available_commands => {'201' => '1'}
          end
          
          should_render_template :new
          should "assign checked devices" do
            assert_equal ['101'], assigns["devices"].checked
          end

          should "assign to available_commands" do
            assert_equal @available_commands, assigns["available_commands"]
          end

          should "assign to devices" do
            assert_equal @devices, assigns["devices"].devices
          end

          should "add to errors" do
            assert_received(@available_commands) {|commands| commands.parse_errors('201' => '1')}
          end
        end
      end

      context "posting" do
        setup do
          post :create, :available_commands => {'101' => "1"}, :device_ids => ['201']
        end
      
        should_redirect_to("nm-5500 commands index") { nm_5500_commands_url }
        should "create commands" do
          assert_received(AvailableCommand) {|command| command.create_commands_for_devices(['201'], {'101'=>'1'})}
        end
      end
    end
  end

  context "on GET to new" do
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
        get :new
      end
      should_render_with_layout "admin"
      
      should "assign to devices" do
        assert_equal @devices, assigns["devices"].devices
      end

      should "assign to available_commands" do
        assert_equal @available_commands, assigns["available_commands"].commands
      end
    end
  end
end