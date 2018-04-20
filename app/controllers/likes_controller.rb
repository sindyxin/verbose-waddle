class LikesController < ApplicationController
    def create
        @user = User.find(session[:user_id])
        @post = Post.find(params[:id])
        @like = Like.create(user: @user, post: @post)
        redirect_to "/bright_ideas"
    end
    
    def destroy
        @user = User.find(session[:user_id])
        @post = Post.find(params[:id])
        @like = @post.likes.where(user: @user)
        Like.delete(@like)
        redirect_to "/bright_ideas"
    end
end
