class Event < ApplicationRecord
  belongs_to :gym
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings

  has_one :chatroom, dependent: :destroy
  has_many :messages, through: :chatroom
end
