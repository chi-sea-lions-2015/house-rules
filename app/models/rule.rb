class Rule < ActiveRecord::Base
  belongs_to :housing_assignment
  has_many :issues, as: :issuable
end
