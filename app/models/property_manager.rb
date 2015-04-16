class PropertyManager < ActiveRecord::Base
  belongs_to :address
  has_many :houses
end
