class CreateSecurities < ActiveRecord::Migration
  def change
    create_table :securities do |t|
      t.string :symbol
      t.string :name
      t.string :industry

      t.timestamps null: false
    end
  end
end
