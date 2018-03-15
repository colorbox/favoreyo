class TweetsController < ApplicationController
  def index
    @tweets = Tweet.where('created_at > ?', 6.hours.ago)
  end
end
