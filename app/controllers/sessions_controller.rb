class SessionsController < ApplicationController
  # skip_before_action :authenticate_user, only: [:new, :create]

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		#登录用户
  		log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # #记住用户
      # remember user
  		redirect_to user
  	else
  		flash.now[:danger] = '用户或密码错误'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
