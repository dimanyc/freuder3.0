FactoryGirl.define do
  factory :listener do
    name             { Faker::Lorem.word }
    search_terms     {
      {
        'keywords':     Faker::Lorem.words,
        'key_mentions': Faker::Lorem.words.map { |w| '@' + w },
        'key_hashtags': Faker::Lorem.words.map { |w| '#' + w }
      }
    }
    trait :no_keywords do
      search_terms   { { 'keywords': [] } }
    end
    trait :not_case_sensitive do
      case_sensitive? { false }
    end
  end
end
