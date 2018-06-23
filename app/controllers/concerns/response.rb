module Response
  def json_response(object, status = :ok, code = 200)
    render json: { message: object, status: status, code: code }
  end
end