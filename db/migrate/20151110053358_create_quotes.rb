class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
   
      t.timestamps null: false
    end
  end
end
