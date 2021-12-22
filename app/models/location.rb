class Location < ApplicationRecord
  has_many :user_account_locations

  enum name: {
    'office' => 'office',
    'home' => 'home',
    'onlocation' => 'onlocation'
  }

  validates_uniqueness_of :name

  COLORS = {
    'office' => 'green',
    'home' => 'pink',
    'onlocation' => 'blue'
  }.freeze

  def color
    COLORS[name]
  end
end