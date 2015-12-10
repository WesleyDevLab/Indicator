class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|

      t.timestamps null: false
    end
  end
end
