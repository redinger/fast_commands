class FastCommands::AbstractController < ApplicationController
  before_filter :authorize_super_admin
  layout "admin"
end
