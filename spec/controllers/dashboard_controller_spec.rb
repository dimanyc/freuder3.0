require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  context '#show' do

    before do
      stub_twitter_api
      user = create(:user)
      sign_in(user)
      get :show
    end

    it 'returns 200 response status' do
      expect(response.status).to eq(200)
    end

  end

end

