class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

# 空白NG
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :address, presence: true
# 文字NG
  validates :postal_code, numericality: true, presence: true
  validates :telephone_number, numericality: true, presence: true
# 6文字以下NG
  validates :encrypted_password, length: { minimum: 6 } 
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
