FactoryBot.define do
  factory :sprint do
    name { Faker::Name.first_name }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    duration { Faker::Number.number(digits: 1) }
    goal { Faker::Lorem.sentence(word_count: 5) }
    current_sprint { false }
    board
  end
end
