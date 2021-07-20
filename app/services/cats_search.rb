# frozen_string_literal: true

class CatsSearch
  def initialize(search_params)
    @search_params = {
      name: search_params[:cats_type].to_s.downcase,
      location: search_params[:user_location].to_s.downcase
    }
  end

  def call
    fetch_all_providers
    filter_results
    @search_params.values.all?(&:present?) ? find_bargain : @fetched_data
  end

  private

  AVAILABLE_PROVIDERS = %w[
    CatsUnlimited
    HappyCats
  ].freeze

  def fetch_all_providers
    @fetched_data = AVAILABLE_PROVIDERS.map do |provider|
      "CatsProviders::#{provider}".constantize.fetch_data
    end.flatten
  end

  def filter_results
    @fetched_data = @fetched_data.select do |cat|
      name_matched = if @search_params[:name].blank?
                       true
                     else
                       cat[:name].to_s.downcase == @search_params[:name]
                     end
     location_matched = if @search_params[:location].blank?
                          true
                        else
                          cat[:location].to_s.downcase == @search_params[:location]
                        end

      name_matched && location_matched
    end
  end

  def find_bargain
    @fetched_data.min { |a, b| a[:price] <=> b[:price] }
  end
end
