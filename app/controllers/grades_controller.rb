class GradesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_grade

  def index
    @grades = Grade.all
  end

  def show
    @grade = Grade.find(params[:id])
    @school = @grade.school
  end

  private

  def grade_params
    params.require(:grade).permit(:name)
  end

  def set_grade
    @grade = Grade.find(params[:id])
  end
end
