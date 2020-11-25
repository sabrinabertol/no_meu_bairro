class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end

  def new
    @post = current_user.posts.build
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  end

def create
    @post = current_user.posts.build(post_params)
    @post.user = current_user
    @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
    @post.neighbourhood = @neighbourhood
  if @post.save
     redirect_to neighbourhood_post_path(@neighbourhood, @post)
  else
     render 'new'
  end
end

def show
 @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
end

def edit
  @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
end

def update
  @neighbourhood = Neighbourhood.find(params[:neighbourhood_id])
  if @post.update(post_params)
    @post.neighbourhood = @neighbourhood
    @post.save
    redirect_to neighbourhood_post_path(@neighbourhood, @post)
  else
   render 'edit'
  end
end

def destroy
  @post.destroy
  redirect_to root_path
end

private

def post_params
  params.require(:post).permit(:title, :content)
end

def find_post
  @post = Post.find(params[:id])
end
end
