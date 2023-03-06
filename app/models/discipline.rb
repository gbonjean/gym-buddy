class Discipline < ApplicationRecord
  has_many :events, through: :event_disciplines
end
