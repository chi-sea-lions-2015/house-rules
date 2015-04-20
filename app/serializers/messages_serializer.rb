class MessagesSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :content, :created_at, :id
  has_one :author, serializer: UserSerializer
  has_one :house, serializer: HouseSerializer
end
