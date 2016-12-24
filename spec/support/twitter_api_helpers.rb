module TwitterAPIHelpers

  def stub_twitter_api
    api = instance_double(TwitterAPI)
    tweets = [{ text:     Faker::Lorem.paragraph,
                id_str:   rand(1..3).to_s,
                user:     Faker::Internet.user_name,
                entities: Array.new }]
    allow(api)
      .to receive(:get_home_timeline)
      .and_return(tweets)
    allow(api)
      .to receive(:start_streaming)
    allow(TwitterAPI).to receive(:new) { api }
  end

end

