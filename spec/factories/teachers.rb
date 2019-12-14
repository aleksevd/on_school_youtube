FactoryBot.define do
  factory :teacher do
    first_name { generate(:string) }
    last_name { generate(:string) }
    description { generate(:string) }

    trait :pure do
    end
  end
end
