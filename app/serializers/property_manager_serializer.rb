class PropertyManagerSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :name, :phone, :email
  # has_one :address, as: :addressable
  # has_many :houses
end
