class UsersController < ApplicationController
  #before_action :set_user
  
  # GET /users
  def index #works
    @users = User.all
        render :json => @users, :include => [:posts=>{:include => (:comments) }]   
  end

  # GET /users/1
  def show #works
    @user = User.find(params[:id])
      render :json => @user, :include => 
        [
          :posts=>{:include=>(:comments) }
        ] 
  end

  # POST /users
  def create #works
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /users/1
  def update #works
    set_user  #@user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy #works
    set_user  #@user = User.find(params[:id])
    #@posts = Post.where(user_id: @user.ids[0])
    if @user.post_count == 0
      @user.destroy
      render json: { message: "Removing success!"}
    end
    if @user.post_count > 0
      render json: { message: "Remove all user`s posts firstly!!"}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:name)
    end
end
