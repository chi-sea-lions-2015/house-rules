class HouseSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :house_key

end
