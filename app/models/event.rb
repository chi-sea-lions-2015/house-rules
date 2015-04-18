class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :housing_assigment
  has_many :issues, as: :issuable

  validates :name, presence: true
  validates :date, presence: true
end
