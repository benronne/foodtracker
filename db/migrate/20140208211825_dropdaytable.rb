class Dropdaytable < ActiveRecord::Migration
  def up
  	drop_table :days
  end

  def down
  	add_table :days
  end
end
