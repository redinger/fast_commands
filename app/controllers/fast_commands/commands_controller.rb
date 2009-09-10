class FastCommands::CommandsController < FastCommands::AbstractController
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
      setup_new_action
      @devices.checked = params[:device_ids]
      @devices.errors.add(:base, 'No devices specified') if @devices.checked.blank?
      @available_commands.parse_errors(params[:available_commands])
      render :new
    end
  end
  
  private
  def setup_new_action
    @devices = Devices.new(::Device.nm5500_devices)
    @available_commands = AvailableCommands.new(AvailableCommand.all(:include => :params))
  end
end