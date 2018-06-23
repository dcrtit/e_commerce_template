class Category < ApplicationRecord
  validates_presence_of :name

  after_create :set_seo

  belongs_to :category, optional: true
  has_many :products, dependent: :destroy

  scope :index_select, -> { select(:id, :name, :url, :description, :category_id) }

  #attr_accessor :id, :name, :description, :url, :category_id, :product_ids



  private

  def set_seo
    update_column(:url, "#{id}-#{Russian.translit(name).parameterize}")
  end
end
