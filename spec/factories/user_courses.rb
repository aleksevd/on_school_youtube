FactoryBot.define do
  factory :user_course do
    association :user, factory: :user
    association :course, factory: :course

    trait :pure do
      user nil
      course nil
    end
  end
end
