class TweetsController < ApplicationController

before_action :redirect_to_index, except: :index
before_action :set_tweet, only: [:edit, :destroy, :update, :show]


def index
  @tweets = Tweet.includes(:user).order("created_at DESC")
end

def new
end

def create
  Tweet.create(text: tweet_params[:text], user_id: current_user.id)
  redirect_to :action => "index"
end

def edit
end

def update
  if @tweet.user_id == current_user.id
       @tweet.update(params.require(:@tweet).permit(:text))
  end
  redirect_to :action => "index"
end

def destroy
  if @tweet.user_id == current_user.id
        @tweet.destroy
  end
    redirect_to :action => "index"
end

def show
end

private

def set_tweet
      @tweet = Tweet.find(params[:id])
end

def tweet_params
    params.require(:tweets).permit(:text)
end

def redirect_to_index
redirect_to :action => "index" unless user_signed_in?
end

end
