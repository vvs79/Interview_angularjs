class RemoveStringFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :string, :string
  end
end
