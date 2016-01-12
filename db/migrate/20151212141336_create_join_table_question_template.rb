class CreateJoinTableQuestionTemplate < ActiveRecord::Migration
  def change
    create_join_table :templates, :questions do |t|
      t.references :template
      t.references :question
    end
  end
end
