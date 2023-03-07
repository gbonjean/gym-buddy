class Event < ApplicationRecord
  belongs_to :gym
  # belongs_to :owner, class_name: "User"
  belongs_to :user

  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings

  has_one :chatroom, dependent: :destroy
  has_many :messages, through: :chatroom
end
