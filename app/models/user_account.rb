class UserAccount < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :account, optional: false
  belongs_to :role, optional: false
  has_many :user_account_locations

  accepts_nested_attributes_for :role
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :user
end