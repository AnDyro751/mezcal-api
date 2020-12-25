module Graphql
  module Types
    class StripeCheckoutItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Stripe checkout item.'
      field :checkout_id, String, null: true
    end
  end
end