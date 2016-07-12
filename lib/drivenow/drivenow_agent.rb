module Drivenow
  class Agent
    require 'open-uri'
    require 'json'

    attr_reader :cars

    # Creates a new instance of the Drivenow::Agent.
    # options:
    #  :city => The city you want to get all for. e.g. :berlin
    #  :api_key => API-Key for access (optional)
    def initialize(options = {})
      cities = self.class.cities

      city_name = options.delete(:city)
      api_key = options.delete(:api_key)

      uri = "https://api2.drive-now.com/cities/#{cities[city_name]}?expand=full"
      options = {
        'Origin' => 'https://de.drive-now.com',
        'X-Language' => 'de',
        'User-Agent' => 'Mozilla/5.0 (X11; Linux x86_64)',
        'X-Api-Key' => api_key,
        'DNT' => '1',
        'Referer' => 'https://de.drive-now.com/',
        'Accept' => 'application/json;v=1.6',
        'Accept-Encoding' => 'gzip, deflate, sdch, br',
        'Accept-Language' => 'en-US,en;q=0.8'
      }.merge(options)

      page = open(uri, options).read
      cars = JSON(page)['cars']['items']
      cars.each { |item| item["cit"] = cities[city_name] }
      cars.map! { |item| Car.new(item) }
      @cars = cars
    end

    def inspect
      @cars.inspect
    end

    # Gets all cities that are available at the moment, currently
    #  * Düsseldorf
    #  * Berlin
    #  * München
    #  * Köln
    #  * Hamburg
    # Can easily be overridden if there are more cities available in the future
    def self.cities
      {
        :duesseldorf => "1293",
        :berlin => "6099",
        :muenchen => "4604",
        :koeln => "1774",
        :hamburg => "40065"
      }
    end
  end
end
