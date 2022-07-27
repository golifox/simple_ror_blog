class PostsController < ApplicationController
  before_action :get_post, except: [:create]
  before_action :get_user, only: [:destroy]

  # POST /posts
  def create 
    @post = Post.new(post_params)

    if @post.save
      get_user
      @user.update(post_count: @user.posts.size)
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update #works
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy #works
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
