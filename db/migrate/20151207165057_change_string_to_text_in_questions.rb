class ChangeStringToTextInQuestions < ActiveRecord::Migration
  def change
    change_table :questions do |_|
      change_column :questions, :content, :text, :limit => nil
      change_column :questions, :answer, :text, :limit => nil
    end
  end
end
