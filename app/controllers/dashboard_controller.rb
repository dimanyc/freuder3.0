class DashboardController < ApplicationController

  before_action :establish_api_connection, only: :show

  def show
    @dashboard_props = { name: 'bar',
                         tweets: @twitter.home_timeline }
    start_stream
  end

  private

  def establish_api_connection
    @twitter = TwitterAPI.new.send(:client)
    @stream  = TwitterAPI.new.send(:stream)
  end

  def start_stream

    @stream.user do |object|
      case object
      when Twitter::Tweet
        ActionCable.server.broadcast(
          'twitter_feed',
          text: object.text)
      end
    end

  end

end
