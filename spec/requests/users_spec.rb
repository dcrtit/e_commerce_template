require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /api/signup' do
    context 'when valid request' do
      before { post '/api/signup', params: valid_attributes }

      it 'creates a new user' do
        expect(json['code']).to eq(201)
      end

      it 'returns success message' do
        expect(json['message']['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['message']['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/api/signup', params: {} }

      it 'does not create a new user' do
        expect(json['code']).to eq(422)
      end

      it 'returns failure message' do
        expect(json['message'])
            .to match(/Validation failed: Password can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end