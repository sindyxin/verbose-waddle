class SessionController < ApplicationController
  def new
  end
  def login
    the_user = User.find_by_email(params[:email])
    if the_user && the_user.authenticate(params[:password])
      session[:user_id] = the_user.id
      redirect_to '/bright_ideas'
    else
      flash[:message] = 'Invalid User, try again!'
      redirect_to '/'
    end
  end
  def destroy
    session[:user_id] = nil 
    redirect_to '/'
  end
end
