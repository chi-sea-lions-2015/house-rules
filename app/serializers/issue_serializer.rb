class IssueSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :reason
end
