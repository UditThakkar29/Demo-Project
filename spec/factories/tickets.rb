FactoryBot.define do
  factory :ticket do
    name { Faker::Name.first_name }
    summary { Faker::Lorem.sentence(word_count: 5) }
    priority { 'Low' }
    status { 'to_do' }
    story_point { Faker::Number.number(digits: 1) }
  end
end
