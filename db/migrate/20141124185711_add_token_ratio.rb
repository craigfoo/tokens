class AddTokenRatio < ActiveRecord::Migration
    def self.up
	    change_table(:users) do |t|
			t.float :token_ratio
		end
	end

	def self.down
		remove_column :users, :token_ratio		
	end


end
