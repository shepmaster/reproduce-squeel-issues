class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.boolean :active
      t.integer :parent_id
    end
  end
end
