FactoryBot.define do
  factory :user do
<<<<<<< HEAD
    sequence(:name)       { |n| "user#{n}" }
    sequence(:username)   { |n| "@user#{n}" }
    sequence(:email)      { |n| "user#{n}@test.com" }
    password              '123456'
    password_confirmation '123456'
=======
    sequence(:name)     { |n| "user#{n}" }
    sequence(:username) { |n| "@user#{n}" }
>>>>>>> d6377022b790d898238b269cc13fcd3351503ce3
    admin false
  end
end
