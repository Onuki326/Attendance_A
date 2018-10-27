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
  #relationshipと紐付け
  has_many :active_relationships, class_name: "Relationship",
                           foreign_key: "requester_id",
                           dependent: :destroy
  #申請している、されているの紐付け(複数)
  has_many :requesting, through: :acrive_relationships, resouce: :requested_id                         
  
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
  
  # ユーザーを申請する
  def requesting(other_user)
    recesting << other_user
  end

  # ユーザーを申請を解除する
  def unrequested(other_user)
    active_relationships.find_by(requested_id: other_user.id).destroy
  end

  # 現在のユーザーが申請してたらtrueを返す
  def requesting?(other_user)
    requesting.include?(other_user)
  end

  # CSV読み込みを許可するカラム
  def self.update_attribute
    ["id", "name", "email", "password",
     "admin","affiliation","employee_number",
     "employee_id","basic_working_hours","starting_work_at","finishing_work_at","sperior"]
  end
  
end

