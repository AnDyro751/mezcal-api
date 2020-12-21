module Graphql
  module Types
    class ShippingMethodItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Shipping method item.'
      field :name, String, null: false
      field :tracking_url, String, null: true
      field :admin_name, Integer, null: true
      field :available_to_all, Boolean, null: true
      field :carrier, String, null: true
    end
  end
end