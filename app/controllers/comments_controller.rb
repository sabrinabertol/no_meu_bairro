class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment: params[:comment][:comment], post: @post)
    @comment.user_id = current_user.id if current_user

    if @comment.save
      redirect_to neighbourhood_post_path(@post.neighbourhood, @post)
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to neighbourhood_posts_path(@post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(params[:comment].permit(:comment))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end
end
