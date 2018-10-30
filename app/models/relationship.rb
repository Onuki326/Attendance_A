class Relationship < ApplicationRecord
  #ユーザーとの紐付け
  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"
  #バリデーション　空はダメ
  validates :requester_id, presence: true
  validates :requested_id, presence: true
   
end