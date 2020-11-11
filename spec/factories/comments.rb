FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    artist { nil }
  end
end
