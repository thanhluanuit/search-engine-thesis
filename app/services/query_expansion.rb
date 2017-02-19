class QueryExpansion
  MAX = 3

  def self.call(query)
    query_expansion = []
    query.split(' ').each do |tag|
      annotation = Annotation.where(name: tag).first
      related_tags = annotation.present? ? annotation.related_tags.first(MAX) : []
      query_expansion += related_tags
    end
    query_expansion.unshift(query).join(", ")
  end
end
