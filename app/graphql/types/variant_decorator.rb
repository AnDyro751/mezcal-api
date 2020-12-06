module Graphql
  module Types
    module VariantDecorator
      def self.prepended(base)
        base.field :display_variant_options, GraphQL::Types::String, null: true
        base.field :display_option_values, SolidusGraphqlApi::Types::OptionValue.connection_type, null: true
      end

      def display_option_values
        object.option_values
      end

      def display_variant_options
        object.options_text
      end

      SolidusGraphqlApi::Types::Variant.prepend self
    end
  end
end