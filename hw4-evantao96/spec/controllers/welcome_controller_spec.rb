require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET index' do
    it 'has a successful response' do
      get :index
      expect(response).to be_success
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
