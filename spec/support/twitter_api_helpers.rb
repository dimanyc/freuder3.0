module TwitterAPIHelpers

  def stub_twitter_api
    client = double(Twitter::REST::Client, home_timeline: :true)
    stream = double(Twitter::Streaming::Client, user: true)
    api    = double(TwitterAPI, client: client, stream: stream)
    tweets = ['wewrwer','1']

    allow(TwitterAPI)
      .to receive(:new)
      .and_return(api)
    allow(client)
      .to receive(:home_timeline)
      .and_return(tweets)
  end

end

