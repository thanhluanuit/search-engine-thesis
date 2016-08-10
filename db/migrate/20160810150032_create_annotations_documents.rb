# Tip:
# A join between Annotation and Document will give the default join table name of "annotations_documents"
# Because: “A” precedes “D” alphabetically
# More details: http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_and_belongs_to_many
#
class CreateAnnotationsDocuments < ActiveRecord::Migration
  def change
    create_table :annotations_documents, :id => false do |t|
      t.integer :annotation_id
      t.integer :document_id
    end

    add_index :annotations_documents, [:annotation_id, :document_id]
  end
end
