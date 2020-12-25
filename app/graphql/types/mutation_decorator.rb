# frozen_string_literal: true

require_relative 'stripe_checkout_item'
module Graphql
  module Types
    module MutationDecorator
      def self.prepended(base)
        base.field :createCheckout,
                   Graphql::Types::StripeCheckoutItem,
                   null: true,
                   description: 'Create stripe checkout'
      end

      def createCheckout
        return nil if current_order.nil?
        Stripe.api_key = 'sk_test_nLhx5k3K0NFLM06YC7nZAQVW003TPd9B70'
        session = Stripe::Checkout::Session
                      .create({
                                  payment_method_types: ['card'],
                                  line_items: [{
                                                   price_data: {
                                                       currency: 'usd',
                                                       product_data: {
                                                           name: 'T-shirt',
                                                       },
                                                       unit_amount: 2000,
                                                   },
                                                   quantity: 1,
                                               }],
                                  mode: 'payment',
                                  # For now leave these URLs as placeholder values.
                                  #
                                  # Later on in the guide, you'll create a real success page, but no need to
                                  # do it yet.
                                  success_url: 'https://example.com/success',
                                  cancel_url: 'https://example.com/cancel',
                              })
        return {checkout_id: session.id}
      end

      def current_order
        context[:current_order]
      end

      SolidusGraphqlApi::Types::Mutation.prepend self
    end
  end
end
