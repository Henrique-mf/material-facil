class SchoolsController < ApplicationController
  # before_action :set_school
  skip_before_action :authenticate_user!

  def index
    @schools = School.all
  end

  def show
    @school = School.find(params[:id])
    @grades = @school.grades.includes(:list)
  end

  private

  def school_params
    params.require(:school).permit(:name, :photo)
  end

  def set_school
    @school = School.find(params[:id])
  end
end
