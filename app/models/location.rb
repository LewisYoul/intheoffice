class Location < ApplicationRecord
  has_many :user_account_locations

  enum name: {
    'office' => 'office',
    'home' => 'home',
    'onlocation' => 'onlocation'
  }

  validates_uniqueness_of :name
end