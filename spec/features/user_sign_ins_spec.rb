require 'rails_helper'

RSpec.feature 'UserSignIns', type: :feature do

  before do
    stub_twitter_api
    stub_streaming_feed
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(create(:user))
  end

  example 'with valid Twitter credentials' do
    visit '/'
    expect(page).to have_content ('Log In with Twitter')
    click_on('Log In with Twitter')
    expect(page).to have_content('habibulin')
  end

end
