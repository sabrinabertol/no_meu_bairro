class Neighbourhood < ApplicationRecord
  has_many :services
  has_many :users
  has_many :news
  has_many :posts
end
