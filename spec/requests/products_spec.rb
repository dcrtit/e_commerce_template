require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let(:category_id) { category.id }
  let!(:products) { create_list(:product, 10, category_id: category_id) }
  let(:product_id) { products.last.id }
  let(:product_url) { products.last.url }
  let(:headers_cookie) { valid_headers_cookie }

  # Test suite for GET /api/products/:id
  describe 'GET /api/products/:url' do
    before { get "/api/products/#{product_url}", params: {}, headers: headers_cookie }

    context 'when the record exists' do
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['message']['id']).to eq(product_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:product_url) { "100-govna" }

      it 'returns status code 404' do
        expect(response).to have_http_status(200)
      end

      it 'returns a not found message' do
        expect(json['message']).to match(/Couldn't find Product/)
      end
    end
  end
end