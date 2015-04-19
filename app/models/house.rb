class House < ActiveRecord::Base
  belongs_to :property_manager

  has_one :address, as: :addressable

  has_many :housing_assignments
  has_many :messages
  has_many :events
  has_many :communal_items
  has_many :chores
  has_many :rules

  has_many :users, through: :housing_assignments
  has_many :events, through: :housing_assignments

  validates :name, presence: true
  validates :house_key, presence: true
end
