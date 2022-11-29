# class CallbacksController < ApplicationController 
# 	def google_oauth2
# 	 	 @user = User.from_omniauth(request.env["omniauth.auth"])
# 	 	if user.present?
# 	 		# @user = User.from_omniauth(request.env["omniauth.auth"])
# 	 		redirect_to user_path(@user)
# 	 	else
# 	 		redirect_to '/user/sign_in'
# 	 	end
# 	end

# 	def failure
#     redirect_to root_path
#   end
# end
