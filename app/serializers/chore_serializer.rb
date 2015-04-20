class ChoreSerializer < ActiveModel::Serializer
  attributes :id, :task
  has_many :issues, as: :issuable
  has_many :user_promises, as: :promisable
  has_one :house
end
