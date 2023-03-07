class Event < ApplicationRecord
  belongs_to :gym
  belongs_to :user

  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users

  has_one :chatroom, dependent: :destroy
  has_many :messages, through: :chatroom
end
