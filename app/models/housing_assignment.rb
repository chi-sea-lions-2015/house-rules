class HousingAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  has_many :rules, through: :house
  has_many :events, through: :house
  has_many :messages, through: :house
end
