class CreateAnnotationsUsers < ActiveRecord::Migration
  def change
    create_table :annotations_users, :id => false do |t|
      t.integer :annotation_id
      t.integer :user_id
    end

    add_index :annotations_users, [:annotation_id, :user_id]
  end
end
