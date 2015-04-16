class User < ActiveRecord::Base
  has_many :housing_assignments
  has_many :houses, through: :housing_assignments
  has_many :property_managers, through: :housing_assignments
  has_many :issues
  has_many :chore_logs
  has_many :user_promises
  has_many :rules, through: :housing_assignments
  has_many :events, through: :housing_assignments
  has_many :messages, through: :housing_assignments
  has_many :commununal_items, through: :housing_assignments
  has_many :chores, through: :housing_assignments
  has_many :addresses, through: :housing_assignments
end
