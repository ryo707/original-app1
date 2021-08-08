class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]

  def index
    @posts = Post.all
  end

  def new
    @posts = Post.new
  end

  def create
    Post.create(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end
  
  def show
  end

  private

  def post_params
    params.require(:post).permit(:nickname, :image, :title, :text)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
