include Spree::Core::ControllerHelpers
require_relative 'review_item'
module Graphql
  module Types
    module ProductDecorator
      def self.prepended(base)
        base.field :depth_variants, SolidusGraphqlApi::Types::Variant.connection_type, null: true
        base.field :taxons, SolidusGraphqlApi::Types::Taxon.connection_type, null: true
        base.field :optionTypes, SolidusGraphqlApi::Types::OptionType.connection_type, null: true
        base.field :reviews, Graphql::Types::ReviewItem.connection_type, null: true
        base.field :avg_rating, GraphQL::Types::String, null: true
        base.field :reviews_count, GraphQL::Types::String, null: false
      end

      def depth_variants
        object.variants.includes(option_values: [:option_type])
      end

      def taxons
        object.taxons
      end

      def reviews
        object.reviews
      end

      def optionTypes
        object.option_types.includes(:option_values)
      end

      def avg_rating
        object.avg_rating.to_s
      end

      def reviews_count
        object.reviews_count
      end

      SolidusGraphqlApi::Types::Product.prepend self
    end
  end
end