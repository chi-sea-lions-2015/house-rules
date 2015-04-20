class EventSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :name, :date, :description

end
