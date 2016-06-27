Installation
=
    gem install 'drivenow'

Get API key
=

You need an API key for requests.

Example
=

```ruby
require 'drivenow'

puts "Available cities: #{Drivenow::Agent.cities.keys.inspect}"

# get all available cars
cars = Drivenow::Agent.new(city: :muenchen, api_key: ENV['DRIVENOW_APIKEY']).cars

car = cars.first
puts car.json.inspect
puts car.address
puts car.name
puts car.long_name
puts car.city
puts car.address.inspect
puts car.automatic?
puts car.license_plate
puts car.model
puts car.position.inspect
puts car.fuel_state
puts car.fuel_type
puts car.transmission
puts car.clean
```
