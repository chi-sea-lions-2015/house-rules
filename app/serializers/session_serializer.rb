class SessionSerializer < ActiveModel::Serializer

  attributes :email, :token_type, :user_id, :access_token, :house_name, :house_id

  def user_id
    object.id
  end

  def token_type
    'Bearer'
  end

  def house_name
    object.houses.first.name
  end

  def house_id
    object.houses.first.id
  end

end
