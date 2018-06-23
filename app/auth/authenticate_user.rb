class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    raise(ExceptionHandler::AuthenticationError, Message.invalid_email) unless user
    raise(ExceptionHandler::AuthenticationError, Message.invalid_password) unless user.authenticate(password)
    user
  end
end