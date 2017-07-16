FactoryGirl.define do
  factory :case do
    association :user
    title { Faker::Book.title }
    expedient { Faker::Number.number(10).to_s }
    date { Faker::Time.between(3.days.ago, DateTime.now) }
  end
end
