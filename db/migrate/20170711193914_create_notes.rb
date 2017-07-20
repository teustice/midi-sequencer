class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.column :value, :string
      t.column :sequence_id, :integer
    end
  end
end
