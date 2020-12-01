module Graphql
  module Types
    module OrderDecorator
      def self.prepended(base)
        base.field :item_count, GraphQL::Types::Int, null: true
      end

      def test
        object.item_count
      end

      SolidusGraphqlApi::Types::Order.prepend self
    end
  end
end