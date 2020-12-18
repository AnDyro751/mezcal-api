module Graphql
  module Resolvers
    module CreateOrderDecorator
      def self.prepend(base) end

      SolidusGraphqlApi::Types::Mutation.prepend self
    end
  end
end