class UserSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :errors

  def errors
    object.errors.messages
  end

end