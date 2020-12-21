# frozen_string_literal: true
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
        # base.field :products, Product.connection_type,
        #            null: false,
        #            description: 'Supported Products.' do
        #   argument :query, Types::InputObjects::ProductsQueryInput, required: false
        # end
      end

      def country_by_iso(iso_code: "")
        # puts "-----------------#{iso_code}----------------"
        Spree::Country.find_by(iso: iso_code)
      end

      SolidusGraphqlApi::Types::Query.prepend self
    end
  end
end