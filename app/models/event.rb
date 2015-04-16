class Event < ActiveRecord::Base
  belong_to :housing_assigment
  has_many :issues, as: :issuable
end
