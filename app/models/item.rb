class Item < ApplicationRecord
  belongs_to :shelf
  mount_uploader :image, ImageUploader
end
