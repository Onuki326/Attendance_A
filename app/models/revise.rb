class Revise < Attendance
  belongs_to :user
  validates :user_id, presence: true
  validates :arrival, presence: true
  validates :leave, presence: true
  validates :sperior_id, presence: true
end  