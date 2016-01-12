class CreateInterviewQuestions < ActiveRecord::Migration
  def change
    create_table :interview_questions do |t|
      t.integer :interview_id
      t.integer :question_id
      t.string :comment
      t.string :mark

      t.timestamps null: false
    end
  end
end
