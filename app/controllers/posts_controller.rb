class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @posts = Post.new
  end

  def create
    Post.create(post_params)
  end

  private
  def post_params
    params.require(:post).permit(:nickname, :image, :title, :text)
  end
end
