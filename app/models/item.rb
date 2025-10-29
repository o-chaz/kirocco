class Item < ApplicationRecord
  belongs_to :shelf
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :image, presence: true, on: create
end
