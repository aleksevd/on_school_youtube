FactoryBot.define do
  factory :user_lesson do
    association :user, factory: :user
    association :lesson, factory: :lesson

    trait :pure do
      user nil
      lesson nil
    end
  end
end
