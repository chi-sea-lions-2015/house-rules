class House < ActiveRecord::Base
  has_one :property_manager
  has_one :address, as: :addressable

  has_many :housing_assignments
  has_many :users, through: :housing_assignments
  has_many :communal_items
  has_many :chores

  validates :name, presence: true
end
