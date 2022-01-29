class Workplace < ApplicationRecord
  belongs_to :account
  has_many :user_accounts
  has_many :active_user_accounts, -> { active }, class_name: 'UserAccount'

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :account_id

  before_destroy :check_for_user_accounts, :check_if_only_workplace, prepend: true

  def destroyable?
    account.workplaces.size > 1 && user_accounts.none?
  end

  private

  def check_for_user_accounts
    return unless user_accounts.any?

    errors.add(:user_accounts, message: 'cannot delete a workplace that members still belong to')
    throw :abort
  end

  def check_if_only_workplace
    return unless account.workplaces.size == 1

    errors.add(:account, message: 'accounts must have at least one workplace')
    throw :abort
  end
end
