Factory.define :available_command do |available_command|
end

Factory.define :available_command_param do |available_command_param|
end

Factory.define :device do |device|
  device.imei {Faker.bothify('##########')}
end