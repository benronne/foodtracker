class Createusertable < ActiveRecord::Migration
  def up
  	create_table :users do |u|
  		u.string :email
  		u.string :password_hash
  		u.string :password_salt
  		u.datetime :created_at
  end
end

	def down
		drop_table :users
	end
end