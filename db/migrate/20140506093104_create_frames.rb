class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.belongs_to :game, index: true
      t.belongs_to :player, index: true

      t.timestamps
    end
  end
end
