FactoryBot.define do
  factory :user do
    sequence(:name)     { |n| "user#{n}" }
    sequence(:username) { |n| "@user#{n}" }
    admin false
  end
end
