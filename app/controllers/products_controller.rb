class ProductsController < ApiController
  # TODO: remove when not doing it in browser
  skip_before_action :authorize_request
  before_action :set_product, only: :show

  # GET /products/:id
  def show
    json_response(@product)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end