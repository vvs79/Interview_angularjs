class AddLevelToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :level, :string
  end
end
