class RemoveSchoolReferenceAndAddGradeReferenceToLists < ActiveRecord::Migration[7.0]
  def change
      # Remove the reference to schools
      remove_reference :lists, :school, foreign_key: true

      # Add a reference to grades
      add_reference :lists, :grade, foreign_key: true
  end
end
