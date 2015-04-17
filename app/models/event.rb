class Event < ActiveRecord::Base
  belongs_to :housing_assigment
  has_many :issues, as: :issuable
end
