# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      # before_action :validate_params

      def index
        return data_not_found_error if process_data.blank?

        render json: process_data
      end

      private

      def index_params
        params.permit(:cats_type, :user_location)
      end

      def process_data
        CatsSearch.new(index_params).call
      end

      def validate_params
        error_keys = index_params.to_h.map{ |k, v| k if v.blank? }.compact
        message = "#{error_keys.join(', ')} is empty"

        render json: {message: message}, status: :bad_request if error_keys.any?
      end

      def data_not_found_error
        render json: {message: 'no results found'}, status: :not_found
      end
    end
  end
end
