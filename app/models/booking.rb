class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :event, uniqueness: { scope: :user, message: "already asked!" }
end
