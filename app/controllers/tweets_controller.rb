class TweetsController < ApplicationController

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = current_user.tweets.all.order('tweets.created_at DESC')
    @users = User.all
    @user = current_user
    respond_to do |format|
      format.html
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    set_tweet
    respond_to do |format|
      format.html
    end
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.build(content: params[:content])
    respond_to do |format|
      if @tweet.save
        format.html {redirect_to tweets_path, notice: 'Tweet was successfully created.'}
        format.js
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to tweets_path }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    set_tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
