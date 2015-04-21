class RuleSerializer < ActiveModel::Serializer

  attributes :id, :content, :created_at, :house_id
  # has_many :issues, as: :issuable


end
