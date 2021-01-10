# shipping_method
#
#
module Graphql
  module Types
    module TaxonomyDecorator
      def self.prepended(base)
        base.field :products, SolidusGraphqlApi::Types::Product.connection_type, null: true
      end

      def products
        object.products
      end

      SolidusGraphqlApi::Types::Taxon.prepend self
    end
  end
end