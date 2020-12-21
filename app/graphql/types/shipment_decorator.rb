module Graphql
  module Types
    module ShipmentDecorator
      def self.prepended(base)
        base.field :shipping_rates, SolidusGraphqlApi::Types::ShippingRate.connection_type, null: true
      end

      def shipping_rates
        object.shipping_rates.includes(:shipping_method)
      end

      SolidusGraphqlApi::Types::Shipment.prepend self
    end
  end
end