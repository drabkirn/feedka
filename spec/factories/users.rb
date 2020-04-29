FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 3..10, separators: %w(_)) }

    password { "12345678" }
    password_confirmation { "12345678" }
    admin { false }

    factory :confirmed_user do
      after(:create) do |user|
        user.confirm
      end
    end

    factory :admin_user do
      before(:create) do |user|
        user.admin = true
      end
    end
  end
end
