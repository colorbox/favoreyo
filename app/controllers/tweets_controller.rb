class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order('id DESC').page(params[:page]).per(5)
  end
end
