FactoryGirl.define do
  factory :tweet do
    author   { '@' + Faker::Internet.user_name }
    body     { Faker::Lorem.paragraph }
    mentions { Faker::Lorem.words.map { |w| '@' + w } }
    hashtags { Faker::Lorem.words.map { |w| '#' + w } }
  end
end
