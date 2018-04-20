class PostsController < ApplicationController
    # before_action :require_login 
    def show
        if session[:user_id]
            @user = User.find(session[:user_id])
        else
            redirect_to '/'
        end
        # Post.joins(:likes).select("COUNT(likes.user_id) as like_count", "posts.*").group("likes.post_id").order("like_count DESC")
        @posts = Post.limit(10)
    end
    def create
        @user = User.find(session[:user_id])
        @post = Post.new(user: @user, content: params[:content])
        if @post.valid?
            @post.save
            redirect_to "/bright_ideas"
        else
            flash[:messages]= @post.errors.full_messages
            redirect_to "/bright_ideas"
        end
    end
    def detail
        @user = User.find(session[:user_id])
        @post = Post.find(params[:id])
        @likes = Like.where(post:@post)
        render 'detail'

    end
    def delete 
        @user = User.find(session[:user_id])
        @post = Post.find(params[:id])
        @post.delete
        redirect_to "/bright_ideas"
    end
end
