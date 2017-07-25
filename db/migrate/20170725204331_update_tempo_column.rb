class UpdateTempoColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :sequences, :tempo
    add_column :sequences, :tempo, :decimal
  end
end
