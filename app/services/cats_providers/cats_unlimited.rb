# frozen_string_literal: true

module CatsProviders
  module CatsUnlimited
    API_URL = ENV['CATS_UNLIMITED_URL']

    def self.fetch_data
      response = RestClient.get(API_URL)
      data = JSON.parse(response.body)
      data.map do |cat|
        {
          name: cat['name'],
          price: cat['price'].to_i,
          location: cat['location']
        }
      end
    end
  end
end
