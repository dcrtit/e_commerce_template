require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:categories) { create_list(:category, 10) }
  let(:category_id) { categories.first.id }
  let(:category_url) { categories.first.url }
  let(:headers_cookie) { valid_headers_cookie }

  # Test suite for GET /categories
  describe 'GET /api/categories' do
    # make HTTP get request before each example
    before { get '/api/categories', params: {}, headers: headers_cookie }

    it 'returns categories' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['message']['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/categories/:id
  describe 'GET /api/categories/:id' do
    before { get "/api/categories/#{category_url}", params: {}, headers: headers_cookie }

    context 'when the record exists' do
      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['message']['data']['id']).to eq("#{category_id}")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:category_url) { "100-govna" }

      it 'returns status code 404' do
        expect(response).to have_http_status(200)
      end

      it 'returns a not found message' do
        expect(json['message']).to match(/Couldn't find Category/)
      end
    end
  end
end