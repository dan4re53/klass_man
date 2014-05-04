class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :rosters, [:user_id]
  end
end
