class Command < ActiveRecord::Base
  belongs_to :device
  delegate :imei, :name, :to => :device, :prefix => true
end
