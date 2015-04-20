class IssueSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :reason
  has_one :creator, class_name: "User"
end
