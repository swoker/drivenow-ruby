
cars = DriveNowAgent.new.cars

car = cars.first
puts car.name
puts car.address.inspect
puts car.automatic?
puts car.license_plate
puts car.model
puts car.position.inspect
puts car.fuel_state
puts car.clean