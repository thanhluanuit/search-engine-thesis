module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name ENV['ELASTICSEARCH_INDEX']

    settings index: { number_of_shards: 1, number_of_replicas: 0 } do
      mapping do
        indexes :description, type: 'string', analyzer: 'standard'

        indexes :annotations, type: 'object' do
          indexes :name, type: 'string', analyzer: 'standard'
        end
      end
    end
  end

  def as_indexed_json(options={})
    as_json(
      include: {
        annotations: { only: :name }
      }
    )
  end

  module ClassMethods

    def elasticsearch(params)
      __elasticsearch__.search(dls_query(params[:query])).page(params[:page])
    end

    private

    def dls_query(query)
      if query.blank?
        {
          query: {
            match_all: {}
          }
        }
      else
        {
          query: {
            multi_match: {
              query: query,
              fields: ["annotations.name", "description"]
            }
          }
        }
      end
    end
  end
end
