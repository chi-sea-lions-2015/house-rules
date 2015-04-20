class PropertyManagerSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :name, :phone, :email

end
