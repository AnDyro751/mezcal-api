module Graphql
  module Types
    class PromotionCodeItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Promotion code item.'
      field :value, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end