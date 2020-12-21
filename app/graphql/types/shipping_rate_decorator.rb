# shipping_method
#
#
include Spree::Core::ControllerHelpers
require_relative 'shipping_method_item'
module Graphql
  module Types
    module ShippingRateDecorator
      def self.prepended(base)
        base.field :shipping_method, Graphql::Types::ShippingMethodItem, null: true
      end

      def shipping_method
        object.shipping_method
      end

      SolidusGraphqlApi::Types::ShippingRate.prepend self
    end
  end
end