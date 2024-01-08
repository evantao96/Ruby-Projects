class TweetsController < ApplicationController
  # Add your controller actions here!

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :body)
  end
end
