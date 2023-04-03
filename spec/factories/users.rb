FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password {"password1"}
    password_confirmation {"password1"}

    after(:create) {|user| user.add_role(:manager)}
  end
end
