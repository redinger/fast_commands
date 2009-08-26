class FastCommands::Nm5500Controller < ApplicationController
  before_filter :authorize_super_admin
  layout "admin"
  
  def show
  end
end
