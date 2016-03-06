class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
