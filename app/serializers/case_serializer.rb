class CaseSerializer < ActiveModel::Serializer
  attributes :id, :title, :expedient, :judge, :date, :errors, :status, :created_at, :updated_at, :user_id

  has_many :comments

  def errors
    object.errors.messages
  end

end