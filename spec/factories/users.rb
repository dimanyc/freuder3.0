FactoryGirl.define do
  factory :user do
    uid         { rand(1...3).to_s }
    screen_name { '@' + Faker::Lorem.word }
    token       {  Faker::Crypto.md5 }
    secret      {  Faker::Crypto.md5 }
  end
end
