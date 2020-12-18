require_relative 'promotion_code_item'

module Graphql
  module Types
    class AdjustmentItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Adjustment item.'
      field :amount, GraphQL::Types::String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :eligible, GraphQL::Types::Boolean, null: false
      field :label, GraphQL::Types::String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :promotion_code, Graphql::Types::PromotionCodeItem, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

    end
  end
end