class UserSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :first_name, :last_name, :email, :phone, :username
  has_many :messages
  has_many :events
  has_many :issues
  has_many :user_promises
  has_many :houses
end
