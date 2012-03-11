require 'test/unit'
require 'drivenow'

class AgentTest < Test::Unit::TestCase
  def setup
		@agent ||= Drivenow::Agent.new
		@agent_berlin ||= Drivenow::Agent.new :city => :berlin
	end
	
	def test_agent_returns_cars
		assert_instance_of Drivenow::Car, @agent.cars.first
		assert_instance_of Drivenow::Car, @agent_berlin.cars.first
	end
	
	def test_berlin_cars
		@agent_berlin.cars.each do |car|
			assert_equal "Berlin", car.city, "city was #{car.city}"
			
			# not really testable, because address can also be Pullerbach or something else
			# assert_equal true, car.address.include?("Berlin"), "address was #{car.address}"
		end
	end
	
	def test_random_cars
		cities = Hash.new { |hash, key| hash[key] = 0}
		@agent.cars.each do |car|
			cities[car.city] += 1
		end
		
		assert_equal true, cities.keys.count >= Drivenow::Agent.cities.keys.count
		Drivenow::Agent.cities.each do |key, value|
			key = key.to_s.capitalize
			assert_equal true, cities.keys.include?(key), "#{key} was not in #{cities.keys.inspect}"
		end		
		
		cities.each do |city, count|
			assert_not_equal 0, count, "Count for #{city} was 0"
		end
	end
	
	def test_wrong_uri
		assert_raise JSON::ParserError, JSON::ParserError do
			x = Drivenow::Agent.new :city => :berlin, :uri => 'http://google.de'
		end
	end
end