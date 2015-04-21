class MessagesSerializer < ActiveModel::Serializer
  # embed :ids, :include => true

  attributes :content, :created_at, :id, :author
  # has_one :house
end
