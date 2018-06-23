class AddDescriptionToCategoryAndProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :description, :string
    add_column :products, :description, :string
  end
end
