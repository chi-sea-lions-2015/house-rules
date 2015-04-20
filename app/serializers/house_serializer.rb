class HouseSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :house_key
  has_one :property_manager

  has_one :address, as: :addressable
  has_many :messages
  has_many :events
  has_many :communal_items
  has_many :chores
  has_many :rules
end
