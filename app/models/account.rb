class Account < ApplicationRecord
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :roles, through: :user_accounts
  has_many :user_account_locations, through: :user_accounts
  has_many :workplaces

  accepts_nested_attributes_for :workplaces

  validates_presence_of :name
end
