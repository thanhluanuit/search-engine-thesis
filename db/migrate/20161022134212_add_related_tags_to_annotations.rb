class AddRelatedTagsToAnnotations < ActiveRecord::Migration
  def change
    add_column :annotations, :related_tags, :text, array:true, default: []
  end
end
