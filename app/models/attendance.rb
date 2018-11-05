class Attendance < ApplicationRecord
  
  belongs_to :user
  validates :user_id, presence: true
  
  enum state: {なし: 0, 申請中: 1, 承認: 2, 否認: 3}
  
end