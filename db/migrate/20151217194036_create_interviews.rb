class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.string :firstname
      t.string :lastname
      t.string :target_level
      t.integer :template_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
