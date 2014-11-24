class CreateTransactions < ActiveRecord::Migration
	def up
	create_table :transactions do |t|
		t.integer "initiator"
		t.integer "jokester"
		t.integer "quantity"
		t.boolean "take_give", default: false
		t.text "comment"
		t.timestamps
	end
	add_index(:transactions, [:initiator, :jokester])
	end

	def down
		drop_table :transactions
	end
end
