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
      __elasticsearch__.search(dls_query(params[:query])).page(params[:page])
    end

    private

    # Rank(d,q,u)  =  Sim(q, d)  +  Sim(q, S(d))  +  Sim(p(u), S(d))
      # => Sim(q, d) : query with content
      # => Sim(q, S(d)) : query with annotations of document
      # => Sim(p(u), S(d)) : annotations of User with annotations of Document

    def dls_query(queries)
      if queries.present?
        should_arr = search_condition(queries)
        functions  = search_functions_score(queries)
        {
          query: {
            function_score: {
              query: {
                bool: {
                  should: should_arr
                }
              },
              functions: functions,
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

    def search_condition(queries)
      should_arr = []
      queries.split(' ').each do |query|
        should_arr += [
          {
            query_string: {
              query: query,
              fields: %w[annotations.name],
              default_operator: 'AND'
            }
          },
          {
            query_string: {
              query: query,
              fields: %w[content],
              default_operator: 'AND'
            }
          }
        ]
      end
      should_arr
    end

    def search_functions_score(queries)
      functions = []
      queries.split(' ').each do |query|
        functions += [
          filter_query(%w[annotations.name], query, 4),
          filter_query(%w[content], query, 3)
        ]
      end
      functions
    end

    def filter_query(fields, query, weight)
      {
        filter: {
          query: {
            filtered: {
              query: {
                bool: {
                  must: [
                    {
                      query_string: {
                        fields:           fields,
                        default_operator: 'AND',
                        query:            query
                      }
                    }
                  ]
                }
              }
            }
          }
        },
        weight: weight
      }
    end
  end
end
