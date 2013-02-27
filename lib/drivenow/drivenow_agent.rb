module Drivenow
	class Agent
		require 'open-uri'
		require 'json'
		$KCODE = "U" if RUBY_VERSION < '1.9.0'

		attr_reader :cars

		# Creates a new instance of the Drivenow::Agent.
		# options:
		#  :city => The City you want to get all for. e.g. :berlin
		#  :uri => The URI can be changed in case you want to test locally or anything else
		#--
		# TODO: Option for the Xpath for cars-array inside the JSON
		def initialize(options = {})
			cities = Agent.cities
			unless options[:city].nil?
				url_params = "cit=#{cities[options[:city]]}"
			end
			options = { :uri => "https://www.drive-now.com/php/metropolis/json.vehicle_filter?#{url_params}" }.merge(options)

			page = open(options[:uri]).read
			cars = JSON(page)["rec"]["vehicles"]["vehicles"]
			cities = cities.invert
			cars.each { |item| item["cit"] = cities[item["cit"]] }
			cars.map! { |item| Car.new(item) }
			@cars = cars
		end
		
		def inspect
			@cars.inspect
		end
		
		# Gets all cities that are available at the moment, currently
		#  * Berlin
		#  * Düsseldorf
		#  * München
		# Can easily be overridden if there are more cities available in the future
		def self.cities
			{
				:duesseldorf => "1293",
				:berlin => "6099", 
				:muenchen => "4604",
				:koeln => "1774"
			}
		end
	end
end
