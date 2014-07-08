class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :author
      t.text :body
      t.integer :user_id

      t.timestamps
    end
    add_index :quotes, :user_id
  end
end
