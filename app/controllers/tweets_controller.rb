class TweetsController < ApplicationController
  def index
    @tweets = Tweet.last(50)
  end

  def show
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
