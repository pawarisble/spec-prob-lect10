class MainController < ApplicationController
  before_action :must_be_logged_in, only: %i[ user_Item ]
  def login
  end

  def create
    u = User.where(login: params[:login]).first
    if u && u.authenticate(params[:password])

      redirect_to main_user_Item_path

      session[:logged_in] = true
      session[:login_user_id] = u.id
    else 
      redirect_to main_login_path, notice: 'wrong username or password'
    end
  end

  def user_Item
    @user_id = session[:login_user_id]
    @user = User.where( id:@user_id ).first
  end

  def destroy
    reset_session
  end
end
