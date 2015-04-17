class HousingAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  has_many :rules
  has_many :events
  has_many :messages
end
