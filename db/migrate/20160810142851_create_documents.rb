class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :url
      t.text :description
      t.text :content

      t.timestamps null: false
    end
  end
end
