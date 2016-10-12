class UsersController < ApplicationController
  def new
  end

  def show
  	@user = User.find(params[:id])
  	# debugger 访问/users/1时，服务器的输出中会显示byebug,可当作控制台，在其中执行代码，ctrl+d退出
  end

end
