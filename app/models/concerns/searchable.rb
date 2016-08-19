module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name ENV['ELASTICSEARCH_INDEX']

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :description, analyzer: 'english'
      end
    end
  end

  def as_indexed_json(options={})
    as_json( only: [:description] )
  end

  def self.search(query) 
    __elasticsearch__.search( 
      { 
        query: { 
          match:  { description: query }
        }
      }
    )
  end
end
