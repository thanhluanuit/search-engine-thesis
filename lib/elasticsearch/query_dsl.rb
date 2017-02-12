module Elasticsearch
  class QueryDsl
    attr_accessor :queries, :user_profile

    def initialize(queries, user_profile)
      @queries = queries
      @user_profile = user_profile
    end

    def get_conditions
      should_arr = []
      queries.split(' ').each do |query|
        should_arr += [
          {
            query_string: {
              query: query,
              fields: %w[annotations.name content],
              default_operator: 'AND'
            }
          }
        ]
      end
      user_profile.split(' ').each do |tag|
        should_arr += [
          {
            query_string: {
              query: tag,
              fields: %w[annotations.name],
              default_operator: 'AND'
            }
          }
        ]
      end
      should_arr
    end

    def get_functions
      functions = []
      queries.split(' ').each do |query|
        functions += [
          filter_query(%w[annotations.name], query, 4),
          filter_query(%w[content], query, 3)
        ]
      end
      user_profile.split(' ').each do |tag|
        functions += [
          filter_query(%w[annotations.name], tag, 2)
        ]
      end
      functions
    end

    private

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
