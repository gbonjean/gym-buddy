class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :bookings, dependent: :destroy
  has_many :owned_events, class_name: 'Event', foreign_key: :owner_id
  has_many :events, through: :bookings

  has_many :chatrooms, through: :events
  has_many :messages

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
