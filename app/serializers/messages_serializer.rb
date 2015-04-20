class MessagesSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :content, :created_at, :id
  has_one :author, class_name: "User"
  has_one :house
end
