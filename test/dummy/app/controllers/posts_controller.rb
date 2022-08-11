class PostsController < ActionController::Base
  def index
    @posts = Post.all
  end
end
