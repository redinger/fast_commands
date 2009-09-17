class FastCommands::CommandsController < FastCommands::AbstractController
  before_filter :find_devices, :only => [:new, :create]
  before_filter :find_available_commands, :only => [:new, :create]

  def index
    if params[:device_id]
      @commands = ::Device.find(params[:device_id]).commands
    else
      @commands = Command.all
    end
  end

  def new
    respond_to do |wants|
      wants.html {render}
      wants.js do
        render :update do |page|
          page.replace_html 'paginated-devices', :partial => 'device_table'
        end
      end
    end
  end

  def create
    if @available_commands.create_commands_for_devices(params[:device_ids],
      params[:available_commands])
      redirect_to nm_5500_commands_path
    else
      @devices.checked = params[:device_ids]
      @devices.errors.add(:base, 'No devices specified') if @devices.checked.blank?
      render :new
    end
  end
  
  private
  def find_available_commands
    @available_commands = AvailableCommands.new(AvailableCommand.ascend_by_name.all)    
  end

  def find_devices
    @devices = Devices.new(::Device.nm5500_devices.ascend_by_name.paginate(:page => params[:page]))    
  end
end