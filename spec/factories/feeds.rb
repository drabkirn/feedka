FactoryBot.define do
  factory :feed do
    association :user, factory: :confirmed_user

    content { Faker::Lorem.paragraph_by_chars(number: 256) }
    public { false }
  end
end
