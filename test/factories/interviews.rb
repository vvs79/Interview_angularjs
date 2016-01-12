FactoryGirl.define do
  factory :interview do
    id 155
    firstname { Faker::Lorem.characters(25) }
    lastname  { Faker::Lorem.characters(50) }
    target_level 'beginner'
    association :template, factory: :template, strategy: :build
  end
end
