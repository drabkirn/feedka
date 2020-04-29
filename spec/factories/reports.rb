FactoryBot.define do
  factory :report do
    association :user, factory: :confirmed_user
    
    content { Faker::Lorem.paragraph_by_chars(number: 256) }
    status { 0 }
    message { "" }
  end
end
