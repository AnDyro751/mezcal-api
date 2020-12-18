# module Graphql
#   module Types
#     module AdjustmentDecorator
#       def self.prepended(base)
#         base.field :promotion_code, Graphql::Types::PromotionCodeItem, null: true
#       end
#
#       def promotionCode
#         object.promotion_code
#       end
#
#       Graphql::Types::AdjustmentItem.prepend self
#     end
#   end
# end