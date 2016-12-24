class DashboardController < ApplicationController

  before_action :establish_api_connection, only: :show
  before_action :auth_user

  def show
    @dashboard_props = { name:   current_user.screen_name,
                         tweets: @api.get_home_timeline }
    start_streaming
  end

  private

  def establish_api_connection
    @api  = TwitterAPI.new(ENV['TOKEN'],
                           ENV['SECRET'])
  end

  def start_streaming
    FeedListenerWorker.perform_async(current_user.id,
                                     ENV['TOKEN'],
                                     ENV['SECRET'])
  end

end
