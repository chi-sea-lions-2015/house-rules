class CommunalItem < ActiveRecord::Base
  belongs_to :house
  has_many :issues, as: :issuable
  has_many :user_promises, as: :promisable

  validates :name, presence: true
  validates :stock_level, inclusion: { in: %w(high low out) }
end
