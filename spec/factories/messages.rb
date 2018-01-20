FactoryBot.define do
  factory :message do
    body 'body of the message'
    conversation
    user
  end
end
