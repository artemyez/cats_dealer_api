# frozen_string_literal: true

require 'open-uri'

module CatsProviders
  module HappyCats
    API_URL = ENV['HAPPY_CATS_URL']

    def self.fetch_data
      response = Kernel.open(API_URL)
      data = Hash.from_xml(response).dig('cats', 'cat')
      data.map do |cat|
        {
          name: cat['title'],
          price: cat['cost'].to_i,
          location: cat['location']
        }
      end
    end
  end
end
