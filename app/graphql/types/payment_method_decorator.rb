require_relative 'source_item'
module Graphql
  module Types
    module PaymentMethodDecorator

      def self.prepended(base)
        base.field :partial_name, GraphQL::Types::String, null: true
        base.field :source, Graphql::Types::SourceItem, null: true
      end

      def source
        object.source
      end

      def partial_name
        object.partial_name
      end

      SolidusGraphqlApi::Types::PaymentMethod.prepend self
    end
  end
end