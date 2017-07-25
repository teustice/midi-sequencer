class AddPlayingToSequence < ActiveRecord::Migration[5.1]
  def change
    add_column :sequences, :playing, :boolean
  end
end
