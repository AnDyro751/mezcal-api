module Graphql
  module Demo
    class RemoveCouponCode < SolidusGraphqlApi::Mutations::BaseMutation
      null true

      argument :body, String, required: true
      argument :post_id, ID, required: true

      field :comment, Graphql::Types::String, null: true

      def resolve(body:, post_id:)
        {
            comment: "DEMO",
        }

      end
    end
  end
end