require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  context 'POST #create' do

    context 'with valid callback args' do

      before do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
      end

      it 'returns 302' do
        post :create
        expect(response.status).to eq(302)
      end

      context 'should assign sessions' do

        example 'to a new User record' do
          expect {
            post :create
          }.to change { User.count }.by(1)
        end

        example 'to a corresponding User instance' do
          create(
            :user,
            uid: '12345',
            screen_name: 'habibulin'
          )
          expect {
            post :create
          }.to change { User.count }.by(0)
        end

      end

      it 'assigns user_id to session' do
        expect {
          post :create
        }.to change {
          session[:user_id] }
            .from(nil)
            .to(a_kind_of(Fixnum))
      end

      it 'assigns user_id to signed cookies' do
        expect {
          post :create
        }.to change {
          cookies[:user_id] }
            .from(nil)
            .to(a_kind_of(Fixnum))
      end

      it 'assigns session token to environment variable' do
        ENV['TOKEN'] = nil
        expect {
          post :create
        }.to change {
          ENV['TOKEN'] }
            .from(nil)
            .to(a_kind_of(String))

      end

      it 'assigns secret token to environment variable' do
        ENV['SECRET'] = nil
        expect {
          post :create
        }.to change {
          ENV['SECRET'] }
            .from(nil)
            .to(a_kind_of(String))

      end

      it 'redirects to dashboard' do
        post :create
        expect(response).to redirect_to dashboard_path
      end

    end

    context 'with invalid callback args' do

      it 'returns 302' do
        post :create
        expect(response.status).to eq(302)
      end

      it 'redirects to root path' do
        post :create
        expect(response).to redirect_to(root_path)
      end

    end

  end

end
