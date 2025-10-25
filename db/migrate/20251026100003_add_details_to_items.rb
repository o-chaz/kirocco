class AddDetailsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :title, :string
    add_column :items, :description, :text
    add_column :items, :purchased_on, :date
    add_column :items, :purchased_at, :string
  end
end
