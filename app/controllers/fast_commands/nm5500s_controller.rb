class FastCommands::Nm5500sController < FastCommands::AbstractController
  def show
    @total_devices = ::Device.nm5500_devices.count
  end
end
