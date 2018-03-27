class TweetsController < ApplicationController
  def index
    @tweets = Tweet.page(params[:page]).per(5)
  end
end
