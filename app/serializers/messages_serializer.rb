# module V1
  class MessagesSerializer < ActiveModel::Serializer

    attributes :content, :created_at, :id
    has_one :author, serializer: UserSerializer

  end
# end
