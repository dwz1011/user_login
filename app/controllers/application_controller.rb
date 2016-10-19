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

end
