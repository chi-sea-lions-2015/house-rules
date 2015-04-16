class Address < ActiveRecord::Base
  has_one :property_mamnager
  has_one :house
end
