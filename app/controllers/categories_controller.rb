class CategoriesController < ApiController
  # TODO: remove when not doing it in browser
  skip_before_action :authorize_request
  before_action :set_category, only: :show

  # GET /categories
  def index
    categories = Category.where(category_id: nil)
    json_response(categories)
  end

  # GET /categories/:id
  def show
    json_response(@category)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end