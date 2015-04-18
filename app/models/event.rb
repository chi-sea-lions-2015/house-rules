class Event < ActiveRecord::Base
  belongs_to :housing_assignment
  has_many :issues, as: :issuable

  validates :name, presence: true
  validates :date, presence: true
end
