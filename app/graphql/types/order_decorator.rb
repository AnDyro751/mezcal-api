module Graphql
  module Types
    module OrderDecorator
      def self.prepended(base)
        base.field :item_count, GraphQL::Types::Int, null: true
        base.field :depth_line_items, SolidusGraphqlApi::Types::LineItem.connection_type, null: true
      end

      def test
        object.item_count
      end

      def line_items
        # Queries::LineItem::VariantQuery.new(line_item: object).call
        object.line_items.includes(:product)
      end

      SolidusGraphqlApi::Types::Order.prepend self
    end
  end
end