class Aploy < ApplicationRecord
  belongs_to :user
  enum state: {なし: 0, 申請中: 1, 承認: 2, 否認: 3}
end