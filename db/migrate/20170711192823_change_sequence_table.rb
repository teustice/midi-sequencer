class ChangeSequenceTable < ActiveRecord::Migration[5.1]
  def change
    add_column :sequences, :notes, :text
    remove_column :sequences, :length
  end
end
