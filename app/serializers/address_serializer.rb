class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city, :state, :zip_code
end
