FactoryBot.define do
  factory :course do
    name { generate(:string) }
    description { generate(:string) }

    association :teacher, factory: :teacher

    after(:build) do |course|
      course.disciplines << build(:discipline) if course.disciplines.empty?
      course.sections << build(:section, :pure) if course.sections.empty?
    end

    trait :pure do
      teacher nil
    end
  end
end
