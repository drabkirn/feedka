FactoryBot.define do
  factory :report do
    user { nil }
    content { "MyText" }
    status { 1 }
    message { "MyText" }
  end
end
