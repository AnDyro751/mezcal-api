module Graphql
  module Types
    module ProductDecorator
      def self.prepended(base)
        base.field :test, GraphQL::Types::String, null: true
      end

      def test
        puts "-----------#{object.attributes}"
        'demo test'
      end

      SolidusGraphqlApi::Types::Product.prepend self
    end
  end
end