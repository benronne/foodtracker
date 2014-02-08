class Removedaycolumn < ActiveRecord::Migration
  def up
  	remove_column :foods, :day_id
  end

  def down
  	add_column :foods, :day_id
  end
end
