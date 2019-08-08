class Place < ApplicationRecord
  has_many :events
  has_many :image, as: :imageable
end
