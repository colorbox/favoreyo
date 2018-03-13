class TweetsController < ApplicationController
  def index
    @tweets = Tweet.where('created_at < ?', 1.day.ago).where('created_at > ?', 2.day.ago)
  end
end
