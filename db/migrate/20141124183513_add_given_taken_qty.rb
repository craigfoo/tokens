class AddGivenTakenQty < ActiveRecord::Migration
    def self.up
	    change_table(:users) do |t|
			t.integer :given, default: 0     
			t.integer :taken, default: 0
		end
	end

	def self.down
		remove_column :users, :given
		remove_column :users, :taken		
	end


end
