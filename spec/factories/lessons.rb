FactoryBot.define do
  factory :lesson do
    name { generate :string }
    association :course, factory: :course

    after(:build) do |lesson|
      lesson.section_id ||= lesson.course&.sections&.first&.id
    end

    trait :pure do
      course nil
    end
  end
end
