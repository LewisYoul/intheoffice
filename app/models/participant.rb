class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :account

  before_save :populate_full_name

  private

  def populate_full_name
    self.full_name = "#{first_name} #{last_name}"
  end
end