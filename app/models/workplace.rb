class Workplace < ApplicationRecord
  belongs_to :account
  has_many :user_accounts

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :account_id
end
