class PostsController < ApplicationController
	before_filter :require_logined, :except => [:index]
  before_filter :find_post, :only => [:show]

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
  		redner new_post_path
  	end
  end

  def show
    if request.post?
      @res = current_user.responses.new params[:response]
      @res.post = @post
      if @res.save
        redirect_to @post
      end
    end
    @res = Response.new
    @ress = @post.responses.latest
  end

  protected

  def find_post
    @post = Post.find(params[:id])
  end
end
