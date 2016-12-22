class TwitterAPI

  # :nocov:
  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = ENV['TOKEN']
      config.access_token_secret = ENV['SECRET']
    end
  end

  def stream
    Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = ENV['TOKEN']
      config.access_token_secret = ENV['SECRET']
    end
  end
  # :nocov:

end
