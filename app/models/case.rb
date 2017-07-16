class Case < ApplicationRecord

  module Statuses
    DESIGNATION      = "designation"
    REMOVED_CITATION = "removed_citation"
    IN_TEST          = "in_test"
    IN_JUDGMENT      = "in_judgment"
    WAITING_PAYMENT  = "waiting_payment"
    ALL              = [DESIGNATION, REMOVED_CITATION, IN_TEST, IN_JUDGMENT, WAITING_PAYMENT]
  end

  
  belongs_to :user
  has_many :comments, -> { order(created_at: :asc) }, as: :commentable

  validates :title, :expedient, :date, :status, presence: true

  def to_s
    title
  end

  def serialized
    CaseSerializer.new(self).as_json
  end

end
