module Graphql
  module Types
    class ReviewItem < SolidusGraphqlApi::Types::Base::RelayNode
      description 'Review Item.'
      field :name, String, null: true
      field :location, String, null: true
      field :rating, Integer, null: true
      field :title, String, null: true
      field :review, String, null: true
      field :approved, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :locale, String, null: true
      field :verified_purchaser, Boolean, null: true
    end
  end
end