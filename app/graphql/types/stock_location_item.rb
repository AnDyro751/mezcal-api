module Graphql
  module Types
    class StockLocationItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Stock location Item.'
      field :name, String, null: true
    end
  end
end