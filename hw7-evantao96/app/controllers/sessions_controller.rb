class SessionsController < ApplicationController
  before_action :set_session, only: %i[create destroy ]

  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    @user = User.find_by(email: params[:email])
    unless @user.nil?
      if @user.password == params[:password]
        session[:user_id] = @user.id
        redirect_to root_url
      else
        redirect_to login_url
      end
    end
  end

  # DELETE /logout
  def destroy
    reset_session
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      session
    end

    # Only allow a list of trusted parameters through.
    def session_params
      params.fetch(:session, {})
    end
end
