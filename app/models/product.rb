class Product < ApplicationRecord
  validates_presence_of :name

  after_create :set_seo

  belongs_to :category

  #attr_accessor :id, :name, :description, :url, :category_id

  private

  def set_seo
    update_column(:url, "#{id}-#{Russian.translit(name).parameterize}")
  end
end
