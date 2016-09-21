require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  context 'GET #home' do

    before(:each) do
      get :home
    end

    it 'returns 200 response status' do
      expect(response.status).to eq(200)
    end

  end

end
