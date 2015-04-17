class CommunalItem < ActiveRecord::Base
  belongs_to :house
  has_many :issues, as: :issuable
  has_many :user_promises, as: :promisable

  validates :name, presence: true
end
