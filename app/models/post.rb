class Post < ApplicationRecord
  belongs_to :user
  belongs_to :neighbourhood
  has_many :comments
end
