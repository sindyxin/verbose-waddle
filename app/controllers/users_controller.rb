class UsersController < ApplicationController

    def create
        user = User.new(name: params[:name], alias: params[:alias], email:params[:email], password:params[:password],password_confirmation: params[:password_confirmation])
        if user.valid?
            user.save
            session[:user_id] = user.id
            redirect_to '/bright_ideas'
        else
            flash[:messages]= user.errors.full_messages
            redirect_to '/'
        end
    end
    def show
        @user = User.find(params[:id])
        @posts = Post.where(user: @user)
        @posts.inject(0){
            |sum, x| sum += x.likes.length 
            @like = sum
        }
        render 'show'
    end
end
