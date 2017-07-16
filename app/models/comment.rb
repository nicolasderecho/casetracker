class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :description, :date, presence: true
  validates :commentable, presence: true

  # def image version = nil
  #   ( user.presence || User.new ).avatar_url(version)
  # end

  def owner
    user
  end

  def serialized
    CommentSerializer.new(self).as_json    
  end

end
