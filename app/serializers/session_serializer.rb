class SessionSerializer < ActiveModel::Serializer

  attributes :email, :token_type, :user_id, :access_token, :house_name
  has_many :houses

  def user_id
    object.id
  end

  def house_name
    object.houses.first.name
  end

  def token_type
    'Bearer'
  end


end
