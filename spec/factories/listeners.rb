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
    trait :empty_search_terms do
      search_terms   {
        {
          'keywords':     [],
          'key_mentions': [],
          'key_hashtags': []
        }
      }
    end
    trait :not_case_sensitive do
      case_sensitive? { false }
    end
    trait :with_slips do
      after(:create) do |listener|
        create(:slip, listener_id: listener.id)
      end
    end
  end
end
