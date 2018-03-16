class TweetsController < ApplicationController
  def index
    @tweets = Tweet.last(50)
  end
end
