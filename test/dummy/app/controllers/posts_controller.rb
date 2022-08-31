class PostsController < ActionController::Base
  def index
    @posts = Post.all
  end

  def show
    head :ok
  end
end
