class ApiController < ApplicationController
  #protect_from_forgery with: :exception
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(cookies).call)[:user]
  end
end