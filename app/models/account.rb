class Account < ApplicationRecord
  has_one :subscription
  has_one :plan, through: :subscription
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :roles, through: :user_accounts
  has_many :workplaces

  accepts_nested_attributes_for :workplaces
  accepts_nested_attributes_for :subscription

  validates_presence_of :name
end
