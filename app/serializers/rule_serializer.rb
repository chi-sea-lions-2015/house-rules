class RuleSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :content

end
