class AddResolutionToSequences < ActiveRecord::Migration[5.1]
  def change
    add_column :sequences, :resolution, :integer
  end
end
