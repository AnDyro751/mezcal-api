# frozen_string_literal: true
require_relative 'promotion_item'
module Graphql
  module Types
    module QueryDecorator
      def self.prepended(base)
        base.field :country_by_iso,
                   SolidusGraphqlApi::Types::Country,
                   null: false,
                   description: 'Find country by iso' do
          argument :iso_code, GraphQL::Types::String, required: true
        end
        base.field :payment_methods,
                   SolidusGraphqlApi::Types::PaymentMethod.connection_type,
                   null: true,
                   description: "Show payment method"
        base.field :taxon_by_permalink,
                   SolidusGraphqlApi::Types::Taxon,
                   null: true,
                   description: "Show taxonomy by permalink" do
          argument :permalink, GraphQL::Types::String, required: true
        end

        base.field :header_promotion, Graphql::Types::PromotionItem,
                   null: true,
                   description: 'Get first promotion code' do
        end
      end


      def header_promotion
        promotion_category = Spree::PromotionCategory.find_by(code: 'header')
        return nil if promotion_category.nil?
        promotion = Spree::Promotion.find_by(promotion_category: promotion_category)
      end

      def taxon_by_permalink(permalink: nil)
        return nil if permalink.nil? || permalink.empty?

        Spree::Taxon.find_by(permalink: permalink)
      end

      def payment_methods
        return nil if current_order.nil?

        current_order.available_payment_methods
      end

      def country_by_iso(iso_code: "")
        # puts "-----------------#{iso_code}----------------"
        Spree::Country.find_by(iso: iso_code)
      end

      def current_order
        context[:current_order]
      end

      SolidusGraphqlApi::Types::Query.prepend self
    end
  end
end