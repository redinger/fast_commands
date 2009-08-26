class FastCommands::Nm5500::DevicesController < ApplicationController
  before_filter :authorize_super_admin
  layout "admin"
  
  def index
    @devices = ::Device.nm5500_devices
  end
end
