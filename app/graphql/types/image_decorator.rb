module Graphql
  module Types
    module ImageDecorator
      def self.prepended(base)
        base.field :customObjectId, GraphQL::Types::ID, null: false
      end

      def customObjectId
        object.id
      end

      SolidusGraphqlApi::Types::Image.prepend self
    end
  end
end