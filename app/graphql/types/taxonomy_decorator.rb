# shipping_method
#
#
module Graphql
  module Types
    module TaxonomyDecorator
      def self.prepended(base)
        base.field :permalink, GraphQL::Types::String, null: true
      end

      def permalink
        object.permalink
      end

      SolidusGraphqlApi::Types::Taxon.prepend self
    end
  end
end