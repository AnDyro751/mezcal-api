include Spree::Core::ControllerHelpers
module Graphql
  module Types
    module ProductDecorator
      def self.prepended(base)
        base.field :depth_variants, SolidusGraphqlApi::Types::Variant.connection_type, null: true
      end

      def depth_variants
        object.variants.includes(option_values: [:option_type])
      end

      SolidusGraphqlApi::Types::Product.prepend self
    end
  end
end