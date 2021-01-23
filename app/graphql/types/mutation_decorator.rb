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
                   description: 'Complete order' do
          argument :session_id, GraphQL::Types::String, required: true
        end

        base.field :addReviewToProduct,
                   Graphql::Types::ReviewItem,
                   null: true,
                   description: 'Add review to product' do
          argument :product_id, GraphQL::Types::String, required: true, loads: SolidusGraphqlApi::Types::Product
          argument :name, GraphQL::Types::String, required: true
          argument :title, GraphQL::Types::String, required: true
          argument :review, GraphQL::Types::String, required: true
          argument :rating, GraphQL::Types::Int, required: true
        end
      end

      def addReviewToProduct(product:, name:, title:, review:, rating:)
        raise GraphQL::ExecutionError, 'Product not found' if product.nil?

        new_review = product.reviews.new(name: name, title: title, rating: rating, review: review)
        if new_review.save
          new_review
        else
          raise GraphQL::ExecutionError, 'No se ha podido agregar la reseña'
          nil
        end
      end

      # Pasar esto a un webhook
      def completeOrder(session_id: nil)
        this_order = Spree::Order.find_by(checkout_identifier: session_id)
        puts "---------#{this_order.nil?}----------"
        return nil if this_order.nil?

        if this_order.complete?
          puts '--------DEBEMOS RETORNAR'
          this_order
        else
          begin
            current_session = Stripe::Checkout::Session.retrieve(session_id)
            if current_session
              if current_session.payment_status === 'paid'
                if this_order.state === 'payment'
                  this_order.next
                  if this_order.can_complete?
                    last_payment = this_order.payments.find_by(state: 'checkout')
                    if last_payment
                      last_payment.complete if last_payment.source.nil?
                    end
                    this_order.complete
                    this_order
                  end
                else
                  puts '--------NOSE puede completar 2'
                end
              end
            end
          rescue StandardError => e
            puts "----------------#{e}----------error"
            nil
          end
        end
      end

      def updateStateOrder(state_id:)
        return nil if current_order.nil?

        state_id = Base64.decode64(state_id).split('-')[-1]
        puts '----current order is nil' if current_order.nil?
        state = Spree::State.find_by(id: state_id)
        puts '----state is nil' if state.nil?
        return nil if state.nil?

        begin
          current_order.update(state: :address)
          bill_address = current_order.bill_address.attributes
          bill_address.delete('id')
          update_params = {
              bill_address: Spree::Address.new(bill_address),
              ship_address: Spree::Address.new(bill_address)
          }
          if Spree::OrderUpdateAttributes.new(current_order, update_params).apply
            current_order.recalculate
            current_order
          end
        rescue StandardError => e
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
                                    allow_promotion_codes: false,
                                    line_items: [{
                                                     price_data: {
                                                         currency: 'mxn',
                                                         product_data: {
                                                             name: "Orden en #{current_store.name}"
                                                         },
                                                         unit_amount: (current_order.total.to_f * 100).to_i
                                                     },
                                                     quantity: 1
                                                 }],
                                    mode: 'payment',
                                    # For now leave these URLs as placeholder values.
                                    #
                                    # Later on in the guide, you'll create a real success page, but no need to
                                    # do it yet.
                                    success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
                                    cancel_url: 'http://localhost:3000/cart'
                                })
          current_order.update(checkout_identifier: session.id)
          {checkout_id: session.id}
        rescue StandardError => e
          puts "----------------#{e}"
          {checkout_id: nil}
        end
      end

      def current_order
        context[:current_order]
      end

      def current_store
        context[:current_store]
      end

      SolidusGraphqlApi::Types::Mutation.prepend self
    end
  end
end
