module V1
  class MessageSerializer < ActiveModel::Serializer

    attributes :content, :created_at, :id
    has_one :author, serializer: V1::UserSerializer

  end
end
