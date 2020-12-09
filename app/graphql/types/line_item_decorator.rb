module Graphql
  module Types
    module LineItemDecorator
      include ActionView::Helpers::NumberHelper
      def self.prepended(base)
        base.field :product, SolidusGraphqlApi::Types::Product, null: true
        base.field :displayPriceAmount, GraphQL::Types::String, null: true
        base.field :displayAmount, GraphQL::Types::String, null: true
      end

      def displayPriceAmount
        ActionController::Base.helpers.number_to_currency(object.price)
      end

      def displayAmount
        ActionController::Base.helpers.number_to_currency(object.amount)
      end

      def product
        object.product
      end

      SolidusGraphqlApi::Types::LineItem.prepend self
    end
  end
end