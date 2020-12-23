require_relative 'stock_location_item'
module Graphql
  module Types
    module ShipmentDecorator
      def self.prepended(base)
        base.field :shipping_rates, SolidusGraphqlApi::Types::ShippingRate.connection_type, null: true
        base.field :stock_location, Graphql::Types::StockLocationItem, null: true
      end


      def stock_location
        object.stock_location
      end

      def shipping_rates
        object.shipping_rates.includes(:shipping_method)
      end


      SolidusGraphqlApi::Types::Shipment.prepend self
    end
  end
end