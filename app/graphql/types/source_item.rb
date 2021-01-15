module Graphql
  module Types
    class SourceItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Source Item.'
      field :gateway_customer_profile_id, String, null: true
      field :gateway_payment_profile_id, String, null: true
      field :default, Boolean, null: true
    end
  end
end