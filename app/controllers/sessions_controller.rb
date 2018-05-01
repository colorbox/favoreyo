class SessionsController < ApplicationController
  protect_from_forgery

  def new
    auth = request.env["omniauth.auth"]
    user = User.find_or_initialize_by(twitter_id: auth.uid)
    user.update!(
      screen_name: auth.info.name,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
    )
    session[:token] = auth.credentials.token
    session[:token_secret] = auth.credentials.secret
    session[:twitter_id] = auth.uid
    redirect_to root_path
  end
end
