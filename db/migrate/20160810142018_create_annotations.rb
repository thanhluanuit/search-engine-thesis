class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
