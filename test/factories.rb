Factory.define :device do |device|
  device.imei {Faker.bothify('##########')}
end

Factory.define :available_command do |available_command|
end