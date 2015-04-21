class SessionSerializer < ActiveModel::Serializer

  attributes :email, :token_type, :user_id, :access_token, :house_name

  def user_id
    object.id
    puts object.id
  end

  def house_name
    object.houses.first.name
    puts object.houses.first.name
  end

  def token_type
    'Bearer'
  end


end
