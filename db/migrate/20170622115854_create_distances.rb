class CreateDistances < ActiveRecord::Migration[5.1]
  def change
    create_table :distances do |t|
      t.integer :from_id
      t.integer :to_id
      t.float :distance
      t.boolean :is_small

      t.timestamps
    end
  end
end
