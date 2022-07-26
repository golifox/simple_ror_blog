class PostsController < ApplicationController
  # POST /posts
  def create 
    get_post
    get_user 

    if @post.save
      @user.update(post_count: @user.posts.size)
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update #works
    get_post
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy #works
    get_post
    get_user
    @users = User.all
    if @post.destroy
      @user.update(post_count: @user.posts.size)
      render json: { message: "Removing success!" }
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def get_user
      @user = User.find_by(id: @post.user_id)
    end

    def get_post
      @post = Post.find((params[:id]))
    end

    def post_params
      params.permit(:title, :body, :user_id)
    end
end
