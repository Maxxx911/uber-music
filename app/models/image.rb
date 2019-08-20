require 'carrierwave/orm/activerecord'
class Image < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Attributes::Dynamic
  include Rails.application.routes.url_helpers

  mount_uploader :media, ImageUploader, mount_on: :media_filename
  belongs_to :imageable, polymorphic: true
end
