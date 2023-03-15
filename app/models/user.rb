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

  has_many :notifications, as: :recipient, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def answers_notifications
    notifications.select { |n| n.params[:answer] }
  end

  def answers
    answers_notifications.map { |n| n.params[:answer] }
  end

  def asks_notifications
    notifications.select { |n| n.params[:ask] }
  end

  def asks
    asks_notifications.map { |n| n.params[:ask] }
  end
  
  def messages_notifications
    notifications.select { |n| n.params[:message] }
  end

  def messages
    messages_notifications.map { |n| n.params[:message] }
  end
end
