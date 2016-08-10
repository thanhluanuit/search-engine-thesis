class CreateDocumentsUsers < ActiveRecord::Migration
  def change
    create_table :documents_users, :id => false do |t|
      t.integer :document_id
      t.integer :user_id
    end

    add_index :documents_users, [:document_id, :user_id]
  end
end
