class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.date :date
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.integer :volume 
      t.integer :security_id     

      t.timestamps null: false
    end

    add_index :quotes, :security_id
  end
end
