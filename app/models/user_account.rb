class UserAccount < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :account, optional: false
  belongs_to :role, optional: false
  belongs_to :workplace, optional: false
  has_many :user_account_locations

  enum status: { active: 'active', inactive: 'inactive' }

  accepts_nested_attributes_for :role
  accepts_nested_attributes_for :account
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :workplace

  def admin?
    role.name == 'Admin'
  end
end