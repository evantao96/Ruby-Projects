  class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy remove_friendship send_friend_request accept_friend_request]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @status = Status.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.password = user_params[:password]
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!
    reset_session
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /friend_requests
  def friend_requests
    unless logged_in?
      redirect_to root_url
    end
  end

  # DELETE /users/1/remove_friendship
  def remove_friendship
    unless logged_in?
      redirect_to root_url
    else
      current_user.remove_friendship(@user)
      redirect_to current_user
    end
  end

  # POST /users/1/send_friend_request
  def send_friend_request
    unless logged_in?
      redirect_to root_url
    else
      current_user.send_friend_request(@user)
      redirect_to current_user
    end
  end

  # PATCH /users/1/accept_friend_request
  def accept_friend_request
    unless logged_in?
      redirect_to root_url
    else
      current_user.accept_friend_request(@user)
      redirect_to current_user
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
