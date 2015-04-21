class CommunalItemSerializer < ActiveModel::Serializer
  # embed :ids, :include => true

  attributes :id, :name, :brand, :quantity, :stock_level, :updated_at
  # has_one :house
  # has_many :issues, as: :issuable
  # has_many :user_promises, as: :promisable

end
