class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  
  # POST /comments
  def create #working
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy #working
    if @comment.destroy
      render json: { message: "Removing success!" }
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:rating, :body, :post_id, :user_id)
    end
end
