FactoryGirl.define do
  factory :slip do
    name          { Faker::Lorem.word }
    slips         {
      {
        keywords: Faker::Lorem.words,
        mentions: Faker::Lorem.words.map { |w| '@'+w },
        hashtags: Faker::Lorem.words.map { |w| '#'+w }
      }
    }
    tweet_id      { rand(1..2) }
  end
end
