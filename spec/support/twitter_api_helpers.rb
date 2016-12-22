module TwitterAPIHelpers

  def stub_twitter_api
    client = double(Twitter::REST::Client, home_timeline: :true)
    stream = double(Twitter::Streaming::Client, user: true)
    api    = double(TwitterAPI, client: client, stream: stream)
    tweets = 3.times { OpenStruct.new(text: Faker::Lorem.word,
                                      author: Faker::Lorem.word) }

    allow(TwitterAPI)
      .to receive(:new)
      .and_return(api)
    allow(client)
      .to receive(:home_timeline)
      .and_return(tweets)
  end

end

