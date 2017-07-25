class AddTempoToSequences < ActiveRecord::Migration[5.1]
  def change
    remove_column :sequences, :playing
    add_column :sequences, :tempo, :decimal
  end
end
