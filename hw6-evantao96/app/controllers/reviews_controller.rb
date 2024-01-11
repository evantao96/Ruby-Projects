class ReviewsController < ApplicationController
  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
