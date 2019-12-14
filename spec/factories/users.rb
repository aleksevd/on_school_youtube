FactoryBot.define do
  factory :user do
    email { generate :email }
    first_name { generate :string }
    last_name { generate :string }
    password { generate :string }
    confirmed_at { Time.zone.now }

    trait :pure do
    end
  end
end
