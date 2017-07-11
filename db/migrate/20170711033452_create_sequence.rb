class CreateSequence < ActiveRecord::Migration[5.1]
  def change
    create_table :sequences do |t|
      t.column :length, :integer
    end
  end
end
