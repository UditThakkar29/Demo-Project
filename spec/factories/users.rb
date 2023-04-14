FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }

    email { Faker::Internet.email }
    password { Faker::Internet.password }

    after(:create) {|user| user.add_role(:user)}

    trait :manager do
      after(:create) {|user| user.add_role(:manager)}
    end
  end
end
