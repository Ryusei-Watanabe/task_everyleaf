class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_many :tasks, dependent: :destroy
  before_update :can_admin_account_remove?
  before_destroy :can_admin_account_destory?
  private
  def can_admin_account_destory?
    if User.all.where(admin: true).count < 2 && self.admin?
      errors.add :base, '管理者権限を持ったユーザーが一人しかいません'
      throw :abort
    end
  end

  def can_admin_account_remove?
    if User.all.where(admin: true).count < 2 && self.admin_change == [true,false]
      errors.add :base, '管理者権限を持ったユーザーが一人しかいません'
      throw :abort
    end
  end
end
