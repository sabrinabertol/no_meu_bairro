class Service < ApplicationRecord
  belongs_to :neighbourhood
  belongs_to :user
  has_many :reviews
  has_many :favourites
end
