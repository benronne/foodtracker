class Createdaytable < ActiveRecord::Migration
  def up
  	create_table :days do |d|
  		d.integer :user_id
  		d.datetime :created_at
  	end
  end

  def down
  	drop_table :days
  end
  
end
