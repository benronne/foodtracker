class Createfoodtable < ActiveRecord::Migration
  def up
  	create_table :foods do |f|
  		f.string :name
  		f.datetime :created_at
  		f.integer :user_id
  end
end

	def down
		drop_table :posts
	end
end
