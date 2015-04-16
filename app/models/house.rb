class House < ActiveRecord::Base
  belongs_to :address
  belongs_to :property_manager
  has_many :housing_assignments
  has_many :users, through: :housing_assignments
  has_many :communal_items
  has_many :chores
end
