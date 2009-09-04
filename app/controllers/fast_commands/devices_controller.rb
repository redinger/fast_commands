class FastCommands::DevicesController < FastCommands::AbstractController
  def index
    @devices = ::Device.nm5500_devices
    @available_commands = AvailableCommand.all
  end
end
