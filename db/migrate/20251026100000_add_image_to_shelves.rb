class AddImageToShelves < ActiveRecord::Migration[7.1]
  def change
    add_column :shelves, :image, :string
  end
end
