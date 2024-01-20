require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  before(:each) do
    User.all.clear
    @user = User.new(name: 'Jackie')
    @user.save
  end

  describe 'GET index' do
    it 'has a successful response' do
      get :index
      expect(response).to be_success
    end

    it 'assigns @tweets' do
      tweet = Tweet.new(user_id: @user.id, body: 'Tweet 1')
      tweet.save
      get :index
      expect(assigns(:tweets)).to match_array([tweet])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    before(:each) do
      @tweet = Tweet.new(user_id: @user.id, body: 'Tweet 1')
      @tweet.save
      get :show, params: { id: @tweet.id }
    end

    it 'has a successful response' do
      expect(response).to be_success
    end

    it 'assigns @tweet' do
      expect(assigns(:tweet)).to eq(@tweet)
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

    it 'assigns @tweet' do
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    before(:each) do
      @tweet = Tweet.new(user_id: @user.id, body: 'Tweet 1')
      @tweet.save
      get :edit, params: { id: @tweet.id }
    end

    it 'has a successful response' do
      expect(response).to be_success
    end

    it 'assigns @tweet' do
      expect(assigns(:tweet)).to eq(@tweet)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    context 'invalid params' do
      before(:each) do
        post :create, params: { tweet: { body: '', user_id: '' } }
      end

      it 'has a successful response' do
        expect(response).to be_success
      end

      it 'assigns but does not successfully save @tweet' do
        expect(assigns(:tweet)).to be_a_new(Tweet)
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'valid params' do
      before(:each) do
        post :create, params: { tweet: { body: 'Tweet 1', user_id: @user.id } }
      end

      it 'has a redirect response' do
        expect(response).to be_redirect
      end

      it 'assigns and successfully saves @tweet' do
        expect(assigns(:tweet)).to_not be_a_new(Tweet)
      end

      it 'redirects to the tweet show page' do
        expect(response).to redirect_to(assigns(:tweet))
      end
    end
  end

  describe 'PATCH update' do
    context 'invalid params' do
      before(:each) do
        @tweet = Tweet.new(user_id: @user.id, body: 'Tweet 1')
        @tweet.save
        patch :update, params: { id: @tweet.id, tweet: { body: '' } }
      end

      it 'has a successful response' do
        expect(response).to be_success
      end

      it 'assigns but does not successfully update @tweet' do
        expect(assigns(:tweet).body).to eq('Tweet 1')
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'valid params' do
      before(:each) do
        @tweet = Tweet.new(user_id: @user.id, body: 'Tweet 1')
        @tweet.save
        patch :update, params: { id: @tweet.id, tweet: { body: 'Updated Tweet 1' } }
      end

      it 'has a redirect response' do
        expect(response).to be_redirect
      end

      it 'assigns and successfully updates @tweet' do
        expect(assigns(:tweet).body).to eq('Updated Tweet 1')
      end

      it 'redirects to tweet show page' do
        expect(response).to redirect_to(assigns(:tweet))
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @tweet = Tweet.new(user_id: @user.id, body: 'Tweet 1')
      @tweet.save
      delete :destroy, params: { id: @tweet.id }
    end

    it 'has a redirect response' do
      expect(response).to be_redirect
    end

    it 'assigns and destroys @tweet' do
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end

    it 'redirects to the tweets index page' do
      expect(response).to redirect_to(tweets_path)
    end
  end
end
