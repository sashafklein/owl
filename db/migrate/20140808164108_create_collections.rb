class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name

      t.timestamps
    end

    add_column :users, :collection_id, :integer
    add_column :quotes, :collection_id, :integer
    add_index :users, :collection_id
    add_index :quotes, :collection_id

    c = Collection.create(name: "Sasha's Collection")
    
    if s = User.first
      s.update_attribute(:collection_id, c.id)
    end
    n = User.create(email: 'nikoklein@gmail.com', collection_id: c.id)

    Quote.update_all(collection_id: c.id)
    
    remove_column :quotes, :user_id
  end
end
