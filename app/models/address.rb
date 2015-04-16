class Address < ActiveRecord::Base
  has_one :property_manager
  has_one :house
end
