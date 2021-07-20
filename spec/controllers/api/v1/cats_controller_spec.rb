require 'rails_helper'

RSpec.describe Api::V1::CatsController, type: :request do
  describe 'Get /api/v1/cats' do
    context 'make request', :vcr do
      let(:params) do
        {
          cats_type: 'Siamese',
          user_location: 'Kharkiv'
        }
      end

      let(:empty_params) do
        {
          cats_type: '',
          user_location: ''
        }
      end

      let(:cats_type_params) do
        {
          cats_type: 'Abyssin',
          user_location: ''
        }
      end

      let(:location_params) do
        {
          cats_type: '',
          user_location: 'Lviv'
        }
      end

      let(:expected_result) do
        {
          'name' => 'Siamese',
          'price' => 20,
          'location' => 'Kharkiv'
        }
      end

      let(:expected_all_quantity) { 21 }
      let(:expected_cat_type_quantity) { 2 }
      let(:expected_location_quantity) { 5 }

      it 'returns correct result' do
        get '/api/v1/cats', params: params

        expect(JSON.parse(response.body)).to eq(expected_result)
      end

      it 'returns all' do
        get '/api/v1/cats', params: empty_params

        expect(JSON.parse(response.body).count).to eq(expected_all_quantity)
      end

      it 'returns only all with cats_type matched' do
        get '/api/v1/cats', params: cats_type_params

        expect(JSON.parse(response.body).count).to eq(expected_cat_type_quantity)
      end

      it 'returns only all with location matched' do
        get '/api/v1/cats', params: location_params

        expect(JSON.parse(response.body).count).to eq(expected_location_quantity)
      end
    end
  end
end
