class Devices
  include Validatable
  attr_accessor :devices, :checked, :id
  
  def initialize(devices = nil)
    self.devices = devices
  end
  
  def each(&block)
    devices.each(&block)
  end
end
