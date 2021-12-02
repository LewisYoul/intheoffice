class UserAccount < ApplicationRecord
  belongs_to :user
  belongs_to :account, inverse_of: :user_accounts
end