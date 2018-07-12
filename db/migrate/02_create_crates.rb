class CreateCrates < ActiveRecord::Migration
  def change
    create_table :crates do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
