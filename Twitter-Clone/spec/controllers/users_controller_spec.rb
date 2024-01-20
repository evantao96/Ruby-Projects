require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:all) { User.all.clear }

  describe 'GET index' do
    it 'has a successful response' do
      get :index
      expect(response).to be_success
    end

    it 'assigns @users' do
      user = User.new(name: 'User 1')
      user.save
      get :index
      expect(assigns(:users)).to match_array([user])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    before(:each) do
      @user = User.new(name: 'User 1')
      @user.save
      get :show, params: { id: @user.id }
    end

    it 'has a successful response' do
      expect(response).to be_success
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(@user)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    before(:each) { get :new }

    it 'has a successful response' do
      expect(response).to be_success
    end

    it 'assigns @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    before(:each) do
      @user = User.new(name: 'User 1')
      @user.save
      get :edit, params: { id: @user.id }
    end

    it 'has a successful response' do
      expect(response).to be_success
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(@user)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    context 'invalid params' do
      before(:each) do
        post :create, params: { user: { name: '' } }
      end

      it 'has a successful response' do
        expect(response).to be_success
      end

      it 'assigns but does not successfully save @user' do
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'valid params' do
      before(:each) do
        post :create, params: { user: { name: 'User 1' } }
      end

      it 'has a redirect response' do
        expect(response).to be_redirect
      end

      it 'assigns and successfully saves @user' do
        expect(assigns(:user)).to_not be_a_new(User)
      end

      it 'redirects to the user show page' do
        expect(response).to redirect_to(assigns(:user))
      end
    end
  end

  describe 'PATCH update' do
    context 'invalid params' do
      before(:each) do
        @user = User.new(name: 'User 1')
        @user.save
        patch :update, params: { id: @user.id, user: { name: '' } }
      end

      it 'has a successful response' do
        expect(response).to be_success
      end

      it 'assigns but does not successfully update @user' do
        expect(assigns(:user).name).to eq('User 1')
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'valid params' do
      before(:each) do
        @user = User.new(name: 'User 1')
        @user.save
        patch :update, params: { id: @user.id, user: { name: 'Updated User 1' } }
      end

      it 'has a redirect response' do
        expect(response).to be_redirect
      end

      it 'assigns and successfully updates @user' do
        expect(assigns(:user).name).to eq('Updated User 1')
      end

      it 'redirects to user show page' do
        expect(response).to redirect_to(assigns(:user))
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @user = User.new(name: 'User 1')
      @user.save
      delete :destroy, params: { id: @user.id }
    end

    it 'has a redirect response' do
      expect(response).to be_redirect
    end

    it 'assigns and destroys @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'redirects to the users index page' do
      expect(response).to redirect_to(users_path)
    end
  end
end
