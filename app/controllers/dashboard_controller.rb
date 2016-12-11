class DashboardController < ApplicationController

  before_action :establish_api_connection

  def show
    puts "--- #{@twitter.inspect}"
    @dashboard_props = { name: 'bar',
                         tweets: @twitter.home_timeline }
  end

  private

  def establish_api_connection
    @twitter = TwitterAPI.new.send(:client)
  end

end
