class Account < ApplicationRecord
  has_many :user_accounts, inverse_of: :account
  has_many :users, through: :user_accounts

  validates_presence_of :name
end
