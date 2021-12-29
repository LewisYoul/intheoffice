class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_accounts
  has_many :accounts, through: :user_accounts
  has_many :roles, through: :user_accounts

  accepts_nested_attributes_for :user_accounts

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, uniqueness: true

  before_save :populate_full_name

  private

  def populate_full_name
    self.full_name = "#{first_name} #{last_name}"
  end
end
