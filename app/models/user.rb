class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :participants
  has_many :user_accounts
  has_many :accounts, through: :user_accounts

  accepts_nested_attributes_for :accounts

  validates :email, uniqueness: true
end
