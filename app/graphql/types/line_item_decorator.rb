module Graphql
  module Types
    module LineItemDecorator
      def self.prepended(base)
        base.field :product, SolidusGraphqlApi::Types::Product, null: true
      end

      def product
        # SolidusGraphqlApi::BatchLoader.for(Spree::LineItem.last, :product)
        object.product
        # SolidusGraphqlApi::BatchLoader.for(object.product, :product)
      end

      SolidusGraphqlApi::Types::LineItem.prepend self
    end
  end
end