require 'rails_helper'


RSpec.describe TweetsController, type: :controller do

  let(:valid_attributes) {
    { content: "Example tweet!", user_id: @user.id }
  }

  let(:invalid_attributes) {
    { content: nil, user_id: nil }
  }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.create( first_name: "John", last_name: "Doe", email: "123@gmail.com", birthday: "1960-08-09", password: "1234example", password_confirmation: "1234example")
    sign_in @user
  end

  describe "GET #index" do
    it "assigns all tweets as @tweets" do
      tweet = Tweet.create! valid_attributes
      get :index, {}
      expect(assigns(:tweets)).to eq([tweet])
    end
  end

  describe "GET #show" do
    it "assigns the requested tweet as @tweet" do
      tweet = Tweet.create! valid_attributes
      get :show, {:id => tweet.to_param}
      expect(assigns(:tweet)).to eq(tweet)
    end
  end

  describe "GET #new" do
    it "assigns a new tweet as @tweet" do
      get :new, {}
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tweet" do
        expect {
          post :create, {:tweet => valid_attributes}
        }.to change(Tweet, :count).by(1)
      end

      it "assigns a newly created tweet as @tweet" do
        post :create, {:tweet => valid_attributes}
        expect(assigns(:tweet)).to be_a(Tweet)
        expect(assigns(:tweet)).to be_persisted
      end

      it "redirects to user tweets" do
        post :create, {:tweet => valid_attributes}
        expect(response).to redirect_to(tweets_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved tweet as @tweet" do
        post :create, {:tweet => invalid_attributes}
        expect(assigns(:tweet)).to be_a_new(Tweet)
      end

      it "flashes a notice and re-renders form" do
        post :create, {:tweet => invalid_attributes}
        expect(response).to redirect_to(tweets_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tweet" do
      tweet = Tweet.create! valid_attributes
      expect {
        delete :destroy, {:id => tweet.to_param}
      }.to change(Tweet, :count).by(-1)
    end

    it "redirects to the tweets list" do
      tweet = Tweet.create! valid_attributes
      delete :destroy, {:id => tweet.to_param}
      expect(response).to redirect_to(tweets_path)
    end
  end

end
