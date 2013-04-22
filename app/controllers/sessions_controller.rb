#encoding: utf-8
class SessionsController < ApplicationController

  layout false

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_name(params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "请输入正确的用户名和密码!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

end
