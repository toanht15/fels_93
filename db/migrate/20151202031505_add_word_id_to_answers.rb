class AddWordIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :word_id, :integer
  end
end
