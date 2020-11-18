class Service < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :neighbourhood
  belongs_to :user
  has_many :reviews
  has_many :favourites
  has_one_attached :photo
end
