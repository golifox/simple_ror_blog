class UsersController < ApplicationController
  before_action :set_user, except: [:index, :create] #good string

  # GET /users
  def index 
    @users = User.order(:registration_date).page params[:page]
        render json: @users
  end

  # GET /users/1
  def show 
    render json: @user.as_json(include: {posts: { include: :comments}})
  end

  # POST /users
  def create 
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /users/1
  def update 
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy 
    if @user.post_count == 0
      @user.destroy
      render json: { message: "Removing success!"}
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
