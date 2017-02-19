class UpdateRelatedTags
  def self.call
    Annotation.find_each do |annotation|
      if annotation.related_tags.blank?
        annotation.related_tags = flickr.tags.getRelated(tag: annotation.name).to_a
        annotation.save!
      end
    end
  end
end

