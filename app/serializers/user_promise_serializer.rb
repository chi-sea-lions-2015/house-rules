class UserPromiseSerializer < ActiveModel::Serializer
  embed :ids, :include => true


  attributes :id, :name, :fulfilled, :creator

end
