class DriveNowAgent
	require 'rubygems'
	require 'open-uri'
	require 'json'
	$KCODE = "U"

	attr_reader :cars

	def initialize(options = {})
		options = { :city => :duesseldorf,
			    :uri => 'https://www.drive-now.com/php/metropolis/vehicle_filter' }.merge(options)

		page = open(options[:uri]).read
		cars = JSON(page)["rec"]["vehicles"]["vehicles"]
		cars = cars.select { |item| item["cit"] == DriveNowAgent.cities[options[:city]] }
		cars.map! { |item| DriveNowCar.new(item) }
		@cars = cars
	end
	
	def self.cities
		{:duesseldorf => "1293",
		:berlin => "6099", 
		:muenchen => "4604"}
	end
end