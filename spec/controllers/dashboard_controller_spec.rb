require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  context '#show' do

    context 'with valid session data' do

      before do
        stub_twitter_api
        user = create(:user)
        sign_in(user)
      end

      it 'returns 200 response status' do
        get :show
        expect(response.status).to eq(200)
      end

      it 'inits FeedListenerWorker' do
        expect {
          get :show
        }.to change(FeedListenerWorker.jobs, :size)
          .by(1)
      end

    end

    context 'with invalid session data' do

      before(:each) do
        get :show
      end

      it 'responds with 304' do
        expect(response.status).to eq(302)
      end

      it 'redirects visitors to root path' do
        expect(response).to redirect_to root_path
      end

    end

  end

end

