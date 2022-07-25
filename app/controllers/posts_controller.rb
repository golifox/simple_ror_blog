class PostsController < ApplicationController
  # POST /posts
  def create #works
    @post = Post.new(post_params) #works
    get_user #@user = User.find_by(id: @post.user_id) #works
    #@post = @user.posts.builder(post_params)
    if @post.save
      @user.update(post_count: @user.posts.size) #works
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update #works
    @post = Post.find((params[:id]))
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy #works
    @post = Post.find((params[:id]))
    get_user
    @users = User.all
    if @post.destroy
      @user.update(post_count: @user.posts.size)
      render :json => @users, :include => [:posts=>{:include => (:comments) }]
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def get_user
      @user = User.find_by(id: @post.user_id)
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:title, :body, :user_id)
    end
end
