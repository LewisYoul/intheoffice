class Role < ApplicationRecord
  enum name: {
    'Admin' => 'Admin',
    'Member' => 'Member'
  }
end