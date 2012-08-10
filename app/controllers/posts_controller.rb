class PostsController < ApplicationController
  before_filter :require_logined, :except => [:index, :show]
  before_filter :find_post, :only => [:show, :reply]

  def index
    @posts = Post.active.page params[:page]
    @is_home = true
    @users_count = User.count
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new params[:post]
    if @post.save
      redirect_to posts_path
    else
      render new_post_path
    end
  end

  def show
    @res = Response.new
    @ress = @post.responses
  end

  def reply
    @res = current_user.responses.new params[:response]
    @res.post = @post
    if @res.save
      redirect_to post_path(@post)
    end
  end

  protected

  def find_post
    @post = Post.find_by_token(params[:id])
  end
end
