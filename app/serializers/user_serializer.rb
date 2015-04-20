class UserSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :first_name, :last_name, :email, :phone, :username

end
