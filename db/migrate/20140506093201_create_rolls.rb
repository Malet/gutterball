class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.belongs_to :frame, index: true
      t.integer :pins

      t.timestamps
    end
  end
end
