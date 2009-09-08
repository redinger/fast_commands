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
    if AvailableCommand.create_commands_for_devices(params[:device_ids],
      params[:available_commands])
      redirect_to nm_5500_commands_path
    else
      flash[:error] = 'No commands specified'
      redirect_to nm_5500_devices_path
    end
  end
end
