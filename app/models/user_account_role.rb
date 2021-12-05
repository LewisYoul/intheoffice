class UserAccountRole < ApplicationRecord
  belongs_to :user_account
  belongs_to :role
end