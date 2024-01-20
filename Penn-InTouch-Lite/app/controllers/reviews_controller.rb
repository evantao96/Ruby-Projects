class ReviewsController < ApplicationController
  before_action :set_course
  before_action :set_review, only: %i[edit update destroy]
  
  # GET /courses/1/reviews/1/edit
  def edit 
  end

  # POST /courses/1/reviews
  def create
    @course.reviews << Review.new(review_params)
    redirect_to @course
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @course, notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @course}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @course, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

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
