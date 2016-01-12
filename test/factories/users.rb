FactoryGirl.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    password '12345678'
    password_confirmation '12345678'
  end

  factory :admin, parent: :user, class: User do
    first_name 'admin'
    admin true
    approved true
  end

  factory :interviewer, parent: :user, class: User do
    admin false
    approved true
  end

  factory :not_approved_interviewer, parent: :user, class: User do
    admin false
    approved false
  end
end
