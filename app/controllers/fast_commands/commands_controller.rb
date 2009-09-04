class FastCommands::CommandsController < FastCommands::AbstractController
  verify :params => :available_commands,
    :only => :create,
    :add_flash => {:error => 'No commands specified'},
    :redirect_to => {:controller => :devices}

  verify :params => :device_ids,
    :only => :create,
    :add_flash => {:error => 'No devices specified'},
    :redirect_to => {:controller => :devices}

  def index
    if params[:device_id]
      @commands = ::Device.find(params[:device_id]).commands
    else
      @commands = Command.all
    end
  end
  
  def create
    AvailableCommand.create_commands_for_devices(params[:available_commands], params[:device_ids])
    redirect_to nm_5500_commands_path
  end
end
