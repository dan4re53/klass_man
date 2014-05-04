class AddRosterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roster_id, :integer
  end
end
