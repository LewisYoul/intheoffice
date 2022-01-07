class Workplace < ApplicationRecord
  belongs_to :account
  has_many :user_accounts

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :account_id

  #add validation to prevent deletion if there are still user_accounts that belong to the workspace
  #will probs need reseed
end
