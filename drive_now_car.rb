class DriveNowCar
	attr_accessor :json

	def initialize(json_param)
		@json = json_param
	end
	
	def name
		@name ||= "#{json['personalName']} (#{json['color']})"
	end
	
	def address
		@address ||= json['address']
	end
	
	def automatic?
		@automatic ||= json['auto'] == 'Y'
	end
	
	def license_plate
		@license ||= json['licensePlate'].gsub('  ', '')
	end
	
	def model
		@model ||= json['model']
	end
	
	def position
		@position ||= json['position']
	end

	def fuel_state
		@fuel_state ||= "#{json['fuelState']}%"
	end

	def clean
		@clean ||= json['innerCleanliness']
	end
end