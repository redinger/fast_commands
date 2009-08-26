class FastCommands::DevicesController < ApplicationController
  before_filter :authorize_super_admin
  layout "admin"
  
  def index
  end
end
