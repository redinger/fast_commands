class FastCommands::CommandsController < FastCommands::AbstractController
  verify :params => :available_commands,
    :only => :create,
    :add_flash => {:error => 'No commands specified'},
    :redirect_to => {:action => :new}

  def index
    if params[:device_id]
      @commands = ::Device.find(params[:device_id]).commands
    else
      @commands = Command.all
    end
  end

  def new
    setup_new_action
  end

  def create
    if AvailableCommand.create_commands_for_devices(params[:device_ids],
      params[:available_commands])
      redirect_to nm_5500_commands_path
    else
      flash[:error] = 'No commands specified'
      setup_new_action
      @devices.checked = params[:device_ids]
      @devices.errors.add(:base, 'No devices specified') if @devices.checked.blank?
      render :new
    end
  end
  
  private
  def setup_new_action
    @devices = Devices.new(::Device.nm5500_devices)
    @available_commands = AvailableCommand.all
  end
end