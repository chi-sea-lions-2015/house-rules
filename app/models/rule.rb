class Rule < ActiveRecord::Base
  belongs_to :house_assignment
  has_many :issues, as: :issuable
end
