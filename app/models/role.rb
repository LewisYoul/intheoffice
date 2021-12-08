class Role < ApplicationRecord
  #TODO: Change to lower case
  enum name: {
    'Admin' => 'Admin',
    'Member' => 'Member'
  }
end