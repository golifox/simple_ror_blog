class UsersController < ApplicationController
  #before_action :set_user
  
  # GET /users
  def index 
    @users = User.order(:registration_date).page params[:page]
        render json: @users
  end

  # GET /users/1
  def show 
    set_user
    @user.as_json(include: posts).find_by(params[:id])
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
    set_user 

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy 
    set_user  

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
