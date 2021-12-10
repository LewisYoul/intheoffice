class Role < ApplicationRecord
  #TODO: Change to lower case
  enum name: {
    'Admin' => 'Admin',
    'Member' => 'Member'
  }

  validates_uniqueness_of :name
end