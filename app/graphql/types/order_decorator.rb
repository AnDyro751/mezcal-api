require_relative 'adjustment_item'

module Graphql
  module Types
    module OrderDecorator
      def self.prepended(base)
        base.field :item_count, GraphQL::Types::Int, null: true
        base.field :depth_line_items, SolidusGraphqlApi::Types::LineItem.connection_type, null: true
        base.field :adjustments, Graphql::Types::AdjustmentItem.connection_type, null: true
        base.field :available_payment_methods, SolidusGraphqlApi::Types::PaymentMethod.connection_type, null: true
      end

      def available_payment_methods
        object.available_payment_methods
      end

      def test
        object.item_count
      end

      def line_items
        object.line_items.includes(:product)
      end

      def adjustments
        object.adjustments.includes(:promotion_code)
      end

      SolidusGraphqlApi::Types::Order.prepend self
    end
  end
end