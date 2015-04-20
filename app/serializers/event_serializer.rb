class EventSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :name, :date, :description
  has_one :house
  has_many :issues, as: :issuable
end
