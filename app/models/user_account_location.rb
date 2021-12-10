class UserAccountLocation < ApplicationRecord
  belongs_to :user_account
  belongs_to :location

  validates_uniqueness_of :location_date, scope: :user_account_id
end