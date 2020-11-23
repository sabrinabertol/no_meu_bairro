# require 'pg_search'

class Service < ApplicationRecord

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :neighbourhood
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name_and_category,
    against: [ :name, :category ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def favourite!
    self.favourite = true
    self.save!
  end

  def unfavourite!
    self.favourite = false
    self.save!
  end

end
