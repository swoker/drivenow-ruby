require 'test/unit'
require 'drivenow'

class CarTest < Test::Unit::TestCase
	def setup
		@valid_hash = {"position" => {
				"latitude" => "48.164372777778",
				"longitude" => "11.594320833333",
				"address" => "Biedersteiner Strasse 29, 80802 Muenchen"},
			"auto" => "N",
			"carName" => "Barbi",
			"cit" => :muenchen,
			"color" => "MIDNIGHT BLACK",
			"fuelState" => "23",
			"group" => "MINI",
			"innerCleanliness" => "super duper clean",
			"licensePlate" => "M  -I 7396",
			"model" => "MINI Cooper",
			"personalName" => "MINI Cooper: Barbi"}
		@valid_car = Drivenow::Car.new @valid_hash
	end

  def test_creation
	assert_not_nil Drivenow::Car.new(@valid_hash)
	assert_raise ArgumentError, ArgumentError do Drivenow::Car.new(nil) end
	assert_raise ArgumentError, ArgumentError do Drivenow::Car.new('...') end
	assert_raise ArgumentError, ArgumentError do Drivenow::Car.new({}) end
  end
  
  def test_automatic
	automatic = Drivenow::Car.new({"auto" => 'Y'})
	manual = Drivenow::Car.new({"auto" => 'N'})
	
	assert_equal true, automatic.automatic?
	assert_equal false, manual.automatic?
	assert_equal false, manual.automatic?
  end
  
  def test_name
	assert_equal "MINI Cooper: Barbi (Midnight black)", @valid_car.name
  end
  
  def test_address
	assert_equal "Biedersteiner Strasse 29, 80802 Muenchen", @valid_car.address
  end
  
  def test_color	
	assert_equal "Midnight black", @valid_car.color
  end
  
  def test_city
	assert_equal "Muenchen", @valid_car.city
  end
  
  def test_plate	
	assert_equal "M-I 7396", @valid_car.license_plate
  end
  
  def test_model	
	assert_equal "MINI Cooper", @valid_car.model
  end
  
  def test_fuel	
	assert_equal "23%", @valid_car.fuel_state
  end
  
  def test_clean	
	assert_equal "super duper clean", @valid_car.clean
  end
  
  def test_position 
	assert_equal "48.164372777778", @valid_car.position["latitude"]
	assert_equal "11.594320833333", @valid_car.position["longitude"]
  end
end