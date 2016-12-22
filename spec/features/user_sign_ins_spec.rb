require 'rails_helper'

RSpec.feature 'UserSignIns', type: :feature, js: true, js_errors: false do

  before do
    stub_twitter_api
  end

  example 'with valid Twitter credentials' do
    visit '/'
    expect(page).to have_content ('Log In with Twitter')
    click_on('Log In with Twitter')
    save_and_open_page
    expect(page).to have_content('habibulin')
  end

end
