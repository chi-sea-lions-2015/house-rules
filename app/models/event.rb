class Event < ActiveRecord::Base
  belong_to :house_assignemnt
  has_many :issues, as: :issuable
end
