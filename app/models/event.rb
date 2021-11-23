class Event < ApplicationRecord
  has_rich_text :content
  has_many :event_participants, dependent: :destroy
  has_many :participants, through: :event_participants

  accepts_nested_attributes_for :participants

  validates_presence_of :title

  attr_accessor :categories
end