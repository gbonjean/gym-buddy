class UserDiscipline < ApplicationRecord
  belongs_to :discipline
  belongs_to :user
end
