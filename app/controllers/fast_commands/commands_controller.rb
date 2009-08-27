class FastCommands::CommandsController < FastCommands::AbstractController
  def index
    device = ::Device.find(params[:device_id])
    @commands = device.commands
  end
end
