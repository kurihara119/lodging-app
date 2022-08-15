class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :rooms
  has_many :reservations

  mount_uploader :image, ImageUploader

  validates :username, presence: true
  validates :profile, presence: true, on: :update
  validates :image, presence: true, on: :update
end
