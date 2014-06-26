class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.where(email: params[:email]).first
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to tasks_url
		else
			flash[:notice] = "Invalid email or password."
			redirect_to new_session_url
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've been signed out."
		redirect_to new_session_url
	end
end
