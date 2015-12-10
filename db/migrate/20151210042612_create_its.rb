class CreateIts < ActiveRecord::Migration
  def change
    create_table :its do |t|
      t.integer :board_id
      t.integer :pin_id

      t.timestamps null: false
    end
  end
end
