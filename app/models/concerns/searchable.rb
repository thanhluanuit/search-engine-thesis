module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name ENV['ELASTICSEARCH_INDEX']

    settings index: { number_of_shards: 1, number_of_replicas: 0 } do
      mapping do
        indexes :content, type: 'string', analyzer: 'english'
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
      __elasticsearch__.search(query_dsl(params)).page(params[:page])
    end

    private

    def query_dsl(params)
      query_dsl = Elasticsearch::QueryDsl.new(params[:query], params[:user_profile])

      if query_dsl.queries.present?
        {
          query: {
            function_score: {
              query: {
                bool: {
                  should: query_dsl.get_conditions
                }
              },
              functions: query_dsl.get_functions,
              boost_mode: 'sum',
              score_mode: 'sum'
            }
          },
          highlight: {
            pre_tags: ['<b><span>'],
            post_tags: ['</span></b>'],
            fields: {
              content: { fragment_size: 1000 }
            }
          }
        }
      else
        {
          query: {
            match_all: {}
          }
        }
      end
    end
  end
end
