FactoryBot.define do
  factory :answer do
    text { generate :string }

    trait :pure do
      user_lesson nil
    end
  end
end
