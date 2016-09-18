FactoryGirl.define do
  factory :listener_tweet do
    listener { create(:listener) }
    tweet    { create(:tweet) }
    slips    {
      {
        'hashtag_slips': Faker::Lorem.words.map { |w| '#' + w },
        'mention_slips': Faker::Lorem.words.map { |w| '@' + w },
        'keyword_slips': Faker::Lorem.words
      }
    }
  end
end
