require 'pg_search'

class Service < ApplicationRecord
  
  belongs_to :neighbourhood
  belongs_to :user
  has_many :reviews
  has_many :favourites
  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end