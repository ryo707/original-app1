FactoryBot.define do
  factory :post do
    title {Faker::Lorem.sentence}
    text  {Faker::Lorem.sentence}
    image {Faker::Lorem.sentence}
    id    {Faker::Lorem.sentence}
    association :user
    
  end
end
