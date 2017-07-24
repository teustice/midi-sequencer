class AddStatusToSequence < ActiveRecord::Migration[5.1]
  def change
    remove_column :sequences, :notes
    add_column :sequences, :playing, :boolean
  end
end
