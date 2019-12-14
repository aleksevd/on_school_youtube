FactoryBot.define do
  factory :flow do
    association :course, factory: :course
    starts_at { generate(:one_day_datetime) }
    checks_finish_at { generate(:one_day_datetime) }
    finishes_at { generate(:one_day_datetime) }
    price 1000

    trait :pure do
      course nil
    end
  end
end
