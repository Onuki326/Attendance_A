class User < ApplicationRecord
  
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password
  #勤怠情報と紐付け
  has_many :attendances, dependent: :destroy
  accepts_nested_attributes_for :attendances
  #勤怠編集申請
  has_many :revise_applications, class_name: "Revise",
                                 dependent: :destroy
  accepts_nested_attributes_for :revise_applications
  #勤怠残業申請
  has_many :overtime_applications, class_name: "Overtime",
                                   dependent: :destroy
  accepts_nested_attributes_for :overtime_applications                         
  #勤怠申請
  has_many :normal_applications, class_name: "Normal",
                                 dependent: :destroy
  accepts_nested_attributes_for :normal_applications 
  # 申請承認ログ
  has_many :approval_attendances, class_name: "Approval_attendance",
                                  dependent: :destroy
  #relationshipと紐付け
  has_many :active_relationships, class_name: "Relationship",
                           foreign_key: "requester_id",
                           dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                           foreign_key: "requested_id",
                           dependent: :destroy                         
                           
  #申請している、されているの紐付け(複数)
  has_many :requesting, through: :active_relationships, source: :requested
  has_many :requesters, through: :passive_relationships, source: :requester
  
  # aployとの紐付け
  has_many :aploys, dependent: :destroy
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # ユーザーの勤怠情報関連
  
  # type: normalの特定の日のarrival取得
  def normal_arrival(day)
    normal_applications.find_by(day: day)&.arrival
  end
  
  # type: normalの特定の日のleave取得
  def normal_leave(day)
    normal_applications.find_by(day: day)&.leave
  end
  
  # 関係性関連
  
  # 申請する
  def approy(sperior)
    requesting << sperior
  end

  # 申請取り消し
  def unapproy(user,sperior)
    user.active_relationships.find_by(requested_id: sperior.id).destroy
  end
  
  # 申請しているか確認(してたらtrue)
  def requesting?(sperior)
    requesting.include?(sperior)
  end
  
  # CSV関連
  
  # CSV読み込み
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      csv = row.to_hash.slice(*update_attribute)
      user = User.find_by(id: csv["id"])
      if user.nil?  
        user = User.new
      end
      user.attributes = row.to_hash.slice(*update_attribute)
      user.save!
    end
  end
  
  # CSV読み込みを許可するカラム
  def self.update_attribute
    ["id", "name", "email", "password",
     "admin","affiliation","employee_number",
     "employee_id","basic_working_hours","starting_work_at","finishing_work_at","sperior"]
  end
  
  
end

