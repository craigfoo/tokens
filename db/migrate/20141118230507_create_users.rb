class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
		t.string "username", :limit => 30
		t.string "first_name", :limit => 25
		t.string "last_name", :limit => 50
		t.string "photo_path", :default => ""
		t.integer "token_bal", :default => 5
		t.timestamps
    end
    add_index :users, :username
  end

  def down
  	drop_table :users  	
  end
end
