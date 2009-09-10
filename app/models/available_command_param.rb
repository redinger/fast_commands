class AvailableCommandParam < ActiveRecord::Base
  belongs_to :available_command
  attr_accessor :value
  
  def title
    label || name.titleize
  end
end