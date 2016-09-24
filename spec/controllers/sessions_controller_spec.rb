require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
  end

  context '#create' do

    it 'returns 200' do
      post :create
      expect(response.status).to eq(302)
    end

    context 'should assign @current_user' do

      example 'to a new User record' do
        request.env['omniauth.auth'].uid = (rand(1...999))
        request.env['omniauth.auth'].screen_name = Faker::Internet.user_name
        expect {
          post :create
        }.to change { User.count }.by(1)

      end

      example 'to a corresponding User instance' do
        request.env['omniauth.auth'].uid = '12345'
        request.env['omniauth.auth'].screen_name = 'dimanyc'
        create(
          :user,
          uid: '12345',
          screen_name: 'dimanyc'
        )
        expect {
          post :create
        }.to change { User.count }.by(0)
      end

    end
  end

end
