class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :neighbourhood, optional: true
  has_many :services
  has_many :posts
  has_many :reviews
  has_many :favourites
  has_many :comments
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def has_favourited?(service)
    favourites.find_by(service_id:service.id).present?
  end
end
