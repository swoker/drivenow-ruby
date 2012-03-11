module Drivenow
	class Agent
		require 'open-uri'
		require 'json'
		$KCODE = "U"

		attr_reader :cars

		# Creates a new instance of the Drivenow::Agent.
		# options:
		#  :city => The City you want to get all for. e.g. :berlin
		#  :uri => The URI can be changed in case you want to test locally or anything else
		#--
		# TODO: Option for the Xpath for cars-array inside the JSON
		def initialize(options = {})
			options = { :uri => 'https://www.drive-now.com/php/metropolis/vehicle_filter' }.merge(options)
			cities = Agent.cities
			
			page = open(options[:uri]).read
			cars = JSON(page)["rec"]["vehicles"]["vehicles"]
			unless options[:city].nil?
				cars = cars.select { |item| item["cit"] == cities[options[:city]] }
			end
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
		#  * Unterhaching (part of M�nchen)
		# Can easily be overridden if there are more cities available in the future
		#--
		# TODO: Unterhaching, Oberding and Korschenbroich are part of other cities... needs to be an array instead of one string
		def self.cities
			{
				:duesseldorf => "1293",
				:berlin => "6099", 
				:muenchen => "4604",
				#:unterhaching => "7590",
				#:oberding => "7591",
				#:korschenbroich => "1294"
			}
		end
	end
end
