FactoryBot.define do
  factory :user do
    sequence(:name)       { |n| "user#{n}" }
    sequence(:username)   { |n| "@user#{n}" }
    sequence(:email)      { |n| "user#{n}@test.com" }
    password              '123456'
    password_confirmation '123456'
    admin false

    after :create, &:confirm
  end
end
