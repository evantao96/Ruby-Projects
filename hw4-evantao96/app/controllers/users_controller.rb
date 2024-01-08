class UsersController < ApplicationController
  # Add your controller actions here!

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
