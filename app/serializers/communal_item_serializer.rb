class CommunalItemSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  
  attributes :id, :name, :brand, :quantity, :stock_level, :updated_at
 
end
