module Drivenow
  class Car
    attr_reader :json

    # initialize a new Car from a Hash that's returned from the drive-now API.
    #
    # Example:
    #  {"address": ["Mitte", "Emdener Str. 52", "10551 Berlin"],
    #  "carImageBaseUrl": "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/{model}/{color}/{density}/car.png",
    #  "carImageUrl": "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/mini_5-tuerer/pepper_white/{density}/car.png",
    #  "color": "midnight_black",
    #  "equipment": [],
    #  "estimatedRange": 567,
    #  "fuelLevel": 0.99,
    #  "fuelLevelInPercent": 99,
    #  "fuelType": "P",
    #  "group": "MINI",
    #  "id": "WMWXS110402C22767",
    #  "innerCleanliness": "CLEAN",
    #  "isCharging": false,
    #  "isInParkingSpace": false,
    #  "isPreheatable": false,
    #  "latitude": 52.528466,
    #  "licensePlate": "M-DX7896",
    #  "longitude": 13.333533,
    #  "make": "BMW",
    #  "modelIdentifier": "mini_5-tuerer",
    #  "modelName": "MINI 5-T\u00fcrer",
    #  "name": "Wilmar",
    #  "parkingSpaceId": null,
    #  "rentalPrice": {
    #      "drivePrice": {
    #          "amount": 31,
    #          "currencyUnit": "ct/min",
    #          "formattedPrice": "31 ct/min"
    #      },
    #      "offerDrivePrice": {
    #          "amount": 20,
    #          "currencyUnit": "ct/min",
    #          "formattedPrice": "20 ct/min"
    #      },
    #      "parkPrice": {
    #          "amount": 15,
    #          "currencyUnit": "ct/min",
    #          "formattedPrice": "15 ct/min"
    #      },
    #      "paidReservationPrice": {
    #          "amount": 10,
    #          "currencyUnit": "ct/min",
    #          "formattedPrice": "10 ct/min"
    #      },
    #      "isOfferDrivePriceActive": false
    #  },
    #  "routingModelName": "mini-5-tuerer",
    #  "series": "MINI",
    #  "transmission": "M",
    #  "variant": "5-Tuerer"}
    def initialize(hash)
      raise ArgumentError, 'hash must be a valid Hash with keys' if hash.nil? || hash.class != {}.class || hash.keys.count == 0

      @json = hash
    end

    # Gets the ID of the car
    # Example: "WMWXS110402C22767"
    def id
      @id ||= json['id']
    end

    # Gets the personal Name and color of the car
    # Example: "MINI Cooper: Barbi (MIDNIGHT BLACK)"
    def long_name
      @name ||= "#{json['series']} #{json['variant']} #{json['name']} (#{color})"
    end

    # Gets the current address
    # Example: "Mitte, Emdener Str. 52, 10551 Berlin"
    def address
      @address ||= json['address'].join(', ')
    end

    # Gets the car's transmission (e.g. "A") which is one of [A: Automatic, M: Manual]
    def transmission
      @transmission ||= json['transmission']
    end

    # Gets if it's an automatic car or manual
    def automatic?
      @automatic ||= json['transmission'] == 'A'
    end

    def color
      @color ||= json['color'].capitalize.gsub('_', ' ')
    end

    # Gets the car's city (e.g. "Berlin")
    def city
      @city ||= json["cit"].to_s.capitalize
    end

    # Gets the car's license plate (e.g. "M-DX7896")
    def license_plate
      @license ||= json['licensePlate'].gsub('  ', '')
    end

    # Gets the car's model (e.g. "BMW 5-Türer")
    def model
      @model ||= json['modelName']
    end

    # Gets the car's current position
    # Example: {:latitude => '00.0000', :longitude => '00.000'}
    def position
      @position ||= {latitude: json['latitude'], longitude: json['longitude']}
    end

    # Gets the car's fuel type which is one of [D: Diesel, P: Petrol, E: Electric]
    # Example: "P"
    def fuel_type
      @fuel_type ||= json['fuelType']
    end

    # Gets the car's fuel state in percent
    # Example: "40%"
    def fuel_state
      @fuel_state ||= "#{json['fuelLevelInPercent']}%"
    end

    # Gets the car's cleanliness state. One of [POOR, REGULAR, CLEAN, VERY_CLEAN]
    def clean
      @clean ||= json['innerCleanliness']
    end
  end
end
