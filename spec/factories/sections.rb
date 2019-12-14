FactoryBot.define do
  factory :section do
    name { generate :string }
    description { generate :string }
    association :course, factory: :course

    trait :pure do
      course nil
    end
  end
end
