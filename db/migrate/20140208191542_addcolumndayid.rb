class Addcolumndayid < ActiveRecord::Migration
	def up
		add_column :foods, :day_id, :integer
	end
  
  def down
  	remove_column :foods, :day_id, :integer
  end

end
