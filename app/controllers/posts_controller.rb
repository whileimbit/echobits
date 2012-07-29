class PostsController < ApplicationController
	before_filter :require_logined, :only => [:new, :create]
  before_filter :find_post, :only => [:show]

  def index
  	@posts = Post.active
    @is_home = true
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = current_user.posts.new params[:post]
  	if @post.save
  		redirect_to posts_path
  	else
  		redner :new
  	end
  end

  def show
    if request.post?
      @res = @post.responses.new params[:response]
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
