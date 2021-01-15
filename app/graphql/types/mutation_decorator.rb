# frozen_string_literal: true
Stripe.api_key = 'sk_test_51H9CZeBOcPJ0nbHctTzfQZhFXBnn8j05e0xqJ5RSVz5Bum72LsvmQKIecJnsoHISEg0jUWtKjERYGeCAEWiIAujP00Fae9MiKm'

require_relative 'stripe_checkout_item'
module Graphql
  module Types
    module MutationDecorator
      def self.prepended(base)
        base.field :createCheckout,
                   Graphql::Types::StripeCheckoutItem,
                   null: true,
                   description: 'Create stripe checkout'
        base.field :updateStateOrder,
                   SolidusGraphqlApi::Types::Order,
                   null: true,
                   description: 'Update order state' do
          argument :state_id, GraphQL::Types::ID, required: true
        end
        base.field :completeOrder,
                   SolidusGraphqlApi::Types::Order,
                   null: true,
                   description: "Complete order" do
          argument :session_id, GraphQL::Types::String, required: true
        end
      end

      def completeOrder(session_id: nil)
        return nil if current_order.nil?
        this_order = Spree::CreditCard.find_by(gateway_payment_profile_id: session_id)
        return nil if this_order.nil?
        begin
          current_session = Stripe::Checkout::Session.retrieve(session_id)
          if current_session
            if current_session.payment_status === "paid"
              if current_order.state === "payment"
                current_order.next
                current_order.complete
              end
            end
          end
        rescue => e
          puts "----------------#{e}----------error"
          return nil
        end

      end

      def updateStateOrder(state_id:)
        return nil if current_order.nil?
        state_id = Base64.decode64(state_id).split('-')[-1]
        puts "----current order is nil" if current_order.nil?
        state = Spree::State.find_by(id: state_id)
        puts "----state is nil" if state.nil?
        return nil if state.nil?

        begin
          current_order.update(state: :address)
          bill_address = current_order.bill_address.attributes
          bill_address.delete("id")
          update_params = {
              bill_address: Spree::Address.new(bill_address),
              ship_address: Spree::Address.new(bill_address)
          }
          if Spree::OrderUpdateAttributes.new(current_order, update_params).apply
            current_order.recalculate
            current_order
          else
            return nil
          end

        rescue => e
          puts "----------#{e}"
          nil
        end
      end

      def createCheckout
        return nil if current_order.nil?

        begin
          session = Stripe::Checkout::Session
                        .create({
                                    customer_email: current_order.email || nil,
                                    payment_method_types: ['card'],
                                    allow_promotion_codes: true,
                                    shipping_address_collection: {
                                        allowed_countries: ["MX"]
                                    },
                                    billing_address_collection: "required",
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
                                    success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
                                    cancel_url: 'http://localhost:3000/cart'
                                })
          return {checkout_id: session.id}
        rescue => e
          puts "----------------#{e}"
          return {checkout_id: nil}
        end
      end

      def current_order
        context[:current_order]
      end

      SolidusGraphqlApi::Types::Mutation.prepend self
    end
  end
end
