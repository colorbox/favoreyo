class SessionsController < ApplicationController
  protect_from_forgery

  def new
    auth = request.env["omniauth.auth"]
    user = User.find_or_initialize_by(twitter_uid: auth.uid)
    user.update!(
      screen_name: auth.info.nickname,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
    )
    session[:token] = auth.credentials.token
    session[:token_secret] = auth.credentials.secret
    session[:twitter_uid] = auth.uid

    user.fetch_favorites_from_timeline if user.tweets.count.zero?

    redirect_to root_path
  rescue Twitter::Error::TooManyRequests
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
