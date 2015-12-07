class RemoveAnswerIdFromWords < ActiveRecord::Migration
  def change
    remove_column :words, :answer_id, :integer
  end
end
