class RuleSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  
  attributes :id, :content
  has_one :house
  has_many :issues, as: :issuable
end
