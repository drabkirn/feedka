FactoryBot.define do
  factory :feed do
    content { "MyText" }
    public { false }
    user { nil }
  end
end
