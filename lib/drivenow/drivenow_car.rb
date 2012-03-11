module Drivenow
	class Car
		attr_reader :json

		# initialize a new Car from a Hash that's returned from the drive-now API.
		# Example:
		# {"position":{
		#		"latitude":"48.164372777778",
		#		"longitude":"11.594320833333",
		#		"address":"Biedersteiner Straße 29, 80802 München"},
		#	"auto":"N",
		#	"carName":"Barbi",
		#	"cit":"4604",
		#	"color":"MIDNIGHT BLACK",
		#	"fuelState":"40",
		#	"group":"MINI",
		#	"innerCleanliness":"CLEAN",
		#	"licensePlate":"M  -I 7396",
		#	"model":"MINI Cooper",
		#	"personalName":"MINI Cooper: Barbi"}
		def initialize(hash)
			raise ArgumentError, 'hash must be a valid Hash with keys' if hash.nil? || hash.class != {}.class || hash.keys.count == 0
			
			@json = hash
		end
		
		# Gets the personal Name and color of the car 
		# Example: "MINI Cooper: Barbi (MIDNIGHT BLACK)"
		def name
			@name ||= "#{json['personalName']} (#{color})"
		end

		# Gets the current address
		# Example: "Biedersteiner Straße 29, 80802 München"
		def address
			@address ||= json['position']['address']
		end

		# Gets if it's an automatic car or manual
		def automatic?
			@automatic ||= json['auto'] == 'Y'
		end
		
		def color
			@color ||= json['color'].capitalize
		end

		# Gets the car's city
		# Example: "Berlin"
		def city
			@city ||= json["cit"].to_s.capitalize
		end

		# Gets the car's license plate (e.g. "M-I 7396")
		def license_plate
			@license ||= json['licensePlate'].gsub('  ', '')
		end

		# Gets the car's model (e.g. "MINI COOPER")
		def model
			@model ||= json['model']
		end

		# Gets the car's current position
		# Example: {:latitude => '00.0000', :longitude => '00.000', :address => 'Musterstraße 01234 Berlin'}
		def position
			@position ||= json['position']
		end

		# Gets the car's fuel state in percent
		# Example: "40%"
		def fuel_state
			@fuel_state ||= "#{json['fuelState']}%"
		end

		# Gets the car's cleanliness state. "CLEAN" normally 
		def clean
			@clean ||= json['innerCleanliness']
		end
	end
end
