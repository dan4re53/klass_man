class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.datetime :date
      t.boolean :service
      t.boolean :sundayschool

      t.timestamps
    end
  end
end
