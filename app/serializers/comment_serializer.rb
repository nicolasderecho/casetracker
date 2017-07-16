class CommentSerializer < ActiveModel::Serializer
  attributes :description, :date, :user_id, :errors, :user, :id

  def user
    UserSerializer.new(object.user)
  end

  def errors
    object.errors.messages
  end

end