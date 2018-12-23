class ListTweetsController < ApplicationController
  before_action :set_user

  def index
    list = @user.lists.find(params[:list_id])
    @tweets = list.list_logs
  end
end
