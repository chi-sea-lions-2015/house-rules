class ChoreSerializer < ActiveModel::Serializer
  attributes :id, :task, :house_id
  # has_many :issues, as: :issuable
  # has_many :user_promises, as: :promisable
end
