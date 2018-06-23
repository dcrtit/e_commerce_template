require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication test suite
  describe 'POST /api/auth/login' do
    # create test user
    let!(:user) { create(:user) }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      { email: user.email, password: user.password }
    end
    let(:invalid_email) do
      { email: Faker::Internet.email, password: Faker::Internet.password }
    end
    let(:invalid_pass) do
      { email: user.email, password: 'NOTfoobar' }
    end

    # set request.headers to our custom headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    # returns auth token when request is valid
    context 'When request is valid' do
      before { post '/api/auth/login', params: valid_credentials }

      it 'returns an authentication token' do
        expect(json['message']['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid' do
      context 'When email is invalid' do
        before { post '/api/auth/login', params: invalid_email }

        it 'returns a failure message' do
          expect(json['message']).to match(/Пользователь с заданным e-mail не найден!/)
        end
      end
      context 'When pass is invalid' do
        before { post '/api/auth/login', params: invalid_pass }

        it 'returns a failure message' do
          expect(json['message']).to match(/Неверный пароль!/)
        end
      end
    end
  end
end