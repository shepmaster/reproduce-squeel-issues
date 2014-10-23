class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.timestamps
      t.references :user
    end
  end
end
