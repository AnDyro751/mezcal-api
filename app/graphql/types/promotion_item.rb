require_relative 'promotion_code_item'
module Graphql
  module Types
    class PromotionItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Promotion item'
      field :description, String, null: true
      field :name, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :codes, Graphql::Types::PromotionCodeItem.connection_type, null: true
    end
  end
end