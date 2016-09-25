require 'rails_helper'

RSpec.feature "UserSignIns", type: :feature do

  example 'with valid Twitter credentials' do
    visit '/'
    expect(page).to have_content ('Log In with Twitter')
    click_on('Log In with Twitter')
    expect(page).to have_content('habibulin')
  end

end
