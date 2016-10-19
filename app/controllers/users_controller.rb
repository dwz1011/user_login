class UsersController < ApplicationController
  before_action :log_in_user, only: [:edit, :update]
  before_action :currect_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	# debugger 访问/users/1时，服务器的输出中会显示byebug,可当作控制台，在其中执行代码，ctrl+d退出
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #更新成功
      flash[:success] = "更新成功"
      redirect_to @user
    elsif 
      #更新失败
      render 'edit'
    end       
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #确保用户已登录
  def log_in_user
    unless logged_in?
      store_location
      flash[:danger] = "请先登录"
      redirect_to login_path
    end
  end

  #确保正确的用户
  def currect_user
    @user = User.find(params[:id])
    flash[:danger] = "只能编辑当前用户"
    redirect_to(root_path) unless current_user?(@user)
  end

end
