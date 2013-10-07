FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    sequence :sc_id do |n|
      "#{Random.rand(100000.999999)}#{n}"
    end
    sequence :email do |n|
      "email#{n}@factory.com"
    end
  end

  factory :project do
    name Faker::Company.catch_phrase
  end

  factory :master_track do
    name Faker::Company.catch_phrase
    sequence :sc_id do |n|
      "#{Random.rand(100000.999999)}#{n}"
    end
  end

  factory :track do
    name Faker::Company.catch_phrase
    sequence :sc_id do |n|
      "#{Random.rand(100000.999999)}#{n}"
    end
  end

  factory :mix_down do 
    name Faker::Company.catch_phrase
    sequence :sc_id do |n|
      "#{Random.rand(100000.999999)}#{n}"
    end
    description Faker::Company.catch_phrase
  end

  factory :genre do
    name Faker::Lorem.word
  end

  factory :instrument do
    name Faker::Lorem.word
  end
end
