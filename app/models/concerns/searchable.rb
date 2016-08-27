module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name ENV['ELASTICSEARCH_INDEX']

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :description, analyzer: 'english'

        indexes :annotations, type: 'nested' do
          indexes :name, analyzer: 'snowball'
        end
      end
    end
  end

  def as_indexed_json(options={})
    as_json(
      only: [:description],
      include: {
        annotations: { only: :name }
      }
    )
  end

  def self.search(query) 
    __elasticsearch__.search( 
      {
        query: {
          multi_match: {
            query: query,
            fields: ["description", "annotations.name"]
          }
        }
      }
    )
  end
end
