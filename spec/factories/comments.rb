FactoryGirl.define do
  factory :comment do
    association :user
    description { Faker::Lorem.sentence(3) }
    date { Faker::Time.between(3.days.ago, DateTime.now) }

    after(:build) do |comment|
      return unless comment.commentable_id.blank? || comment.commentable_type.blank?
      commentable              = create(:case)
      comment.commentable_id   = commentable.id
      comment.commentable_type = commentable.class.to_s
    end

    trait :automatic do
      user nil
    end

  end
end
