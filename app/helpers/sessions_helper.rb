module SessionsHelper
	#登录指定的用户
	def log_in(user)
		session[:user_id] = user.id
	end

	#在持久会话中记住用户
	def remember(user)
		user.remember
		#signed-->为了避免攻击者窃取用户的账户，而对cookie签名，在存入浏览器之前安全加密
		#permanent-->为了永久的存储用户ID
		cookies.permanent.signed[:user_id] = user.id	
		#存储 cookie后，再访问页面时可以使用下面的代码取回用户
		cookies.permanent[:remember_token] = user.remember_token
	end

	# 如果指定用户是当前用户，返回 true
	def current_user?(user)
		user == current_user
	end

	#返回当前登录的用户（如果有的话）
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id]) 
			raise
			user = User.find_by(id: user_id)
			if user && user.autenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
				
	end

	#如果用户已登录，返回true，否则返回false
	def logged_in?
		!current_user.nil?
	end

	#忘记持久会话
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	#重定向到存储的地址或默认地址
	def redirect_back_or(default)
	    redirect_to(session[:forwarding_url] || default)
	    session.delete(:forwarding_url)
  	end

	#存储后面需要使用的地址
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

end
