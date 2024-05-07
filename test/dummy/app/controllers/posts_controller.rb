class PostsController < ActionController::Base
  def index
    @posts = Post.all
    sleep 0.03 # Simulate 30ms of work for performance test
  end

  def show
    head :ok
  end
end
