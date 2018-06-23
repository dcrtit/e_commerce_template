class AuthorizeApiRequest
  def initialize(cookie = {})
    @cookie = cookie
  end

  # Service entry point - return valid user object
  def call
    { user: user }
  end

  private

  attr_reader :cookie

  def user
    # check if user is in the database
    # memoize user object
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(
          ExceptionHandler::InvalidToken,
          ("#{Message.invalid_token} #{e.message}")
    )
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # check for token in `Authorization` header
  def http_auth_header
    return cookie['_ga_stnwlf'] if cookie['_ga_stnwlf'].present?
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end