FactoryBot.define do
  factory :subscription do
    subscription_status { "MyString" }
    subscription_end_date { "2023-04-11 16:19:16" }
    subsciption_start_date { "2023-04-11 16:19:16" }
    user { nil }
    plan { nil }
  end
end
