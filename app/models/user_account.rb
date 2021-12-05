class UserAccount < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :role

  accepts_nested_attributes_for :role
  accepts_nested_attributes_for :account
end