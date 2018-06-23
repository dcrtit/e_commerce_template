module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern
  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ExceptionHandler::AuthenticationError, with: :auth_error
    rescue_from ExceptionHandler::MissingToken, with: :auth_error
    rescue_from ExceptionHandler::InvalidToken, with: :auth_error
  end

  private

  def not_found(e)
    json_response(e.message, :error, 404)
  end

  def auth_error(e)
    json_response(e.message, :error, 420)
  end

  def unprocessable_entity(e)
    json_response(e.message, :error, 422)
  end

  def error(e)
    json_response(e.message, :error, 400)
  end
end