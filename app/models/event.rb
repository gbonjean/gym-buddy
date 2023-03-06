class Event < ApplicationRecord
  belongs_to :gym
  belongs_to :user
  has_one :chatroom
  has_many :messages, through: :chatroom
  has_many :disciplines, through: :event_disciplines
  has_many :users, through: :event_users

end
