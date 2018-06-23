class AddUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :url, :string
    add_column :products, :url, :string
  end
end
