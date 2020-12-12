include Spree::Core::ControllerHelpers
module Graphql
  module Types
    module ProductDecorator
      def self.prepended(base)
        base.field :depth_variants, SolidusGraphqlApi::Types::Variant.connection_type, null: true
        base.field :taxons, SolidusGraphqlApi::Types::Taxon.connection_type, null: true
        base.field :optionTypes, SolidusGraphqlApi::Types::OptionType.connection_type, null: true
      end

      def depth_variants
        object.variants.includes(option_values: [:option_type])
      end

      def taxons
        object.taxons
      end

      def optionTypes
        object.option_types.includes(:option_values)
      end

      SolidusGraphqlApi::Types::Product.prepend self
    end
  end
end