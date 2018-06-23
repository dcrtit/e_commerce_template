require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create test user
  let(:user) { create(:user) }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # invalid request subject
  subject(:invalid_email_obj) { described_class.new('foo', user.password) }
  subject(:invalid_pass_obj) { described_class.new(user.email, 'bar') }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
      context 'when invalid email' do
        it 'raises and auth error' do
          expect { invalid_email_obj.call }
              .to raise_error(
                      ExceptionHandler::AuthenticationError,
                      /Пользователь с заданным e-mail не найден!/
                  )
        end
      end
      context 'when invalid password' do
        it 'raises an authentication error' do
          expect { invalid_pass_obj.call }
              .to raise_error(
                      ExceptionHandler::AuthenticationError,
                      /Неверный пароль!/
                  )
        end
      end
    end
  end
end