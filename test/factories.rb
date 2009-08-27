Factory.define :device do |device|
  device.imei {Faker.bothify('##########')}
end