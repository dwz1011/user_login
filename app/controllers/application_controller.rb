class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # def hello
  # 	render html: 'hello world!'
  # end 

  # before_action :authenticate_user 

  # private
  # 	def authenticate_user
  # 		unless !current_user.nil?
  # 			redirect_to login_path
  # 		end
  # 	end

  private
  #确保用户已登录
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "请先登录"
      redirect_to login_path
    end
  end
end
