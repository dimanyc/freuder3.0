FactoryGirl.define do
  factory :user do
    uid         { rand(1...3).to_s }
    screen_name { '@' + Faker::Lorem.word }
  end
end
