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
    redirect_to root_path
  end

  def destroy
    session[:token] = nil
    session[:token_secret] = nil
    session[:twitter_uid] = nil
    redirect_to root_path
  end
end
