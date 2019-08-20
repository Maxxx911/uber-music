class Image < ApplicationRecord
  mount_uploader :url, ImageUploader
  belongs_to :imageable, polymorphic: true
end
