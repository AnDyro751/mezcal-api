module OrderDecorator

  def self.prepended(base)
    base.checkout_flow do
      go_to_state :address
      go_to_state :delivery
      go_to_state :payment, if: ->(order) {
        order.recalculate
        order.payment_required?
      }
      go_to_state :confirm, if: ->(order) { order.confirmation_required? }
      go_to_state :complete
      # remove_transition from: :delivery, to: :confirm
    end
    # base.remove_checkout_step :payment
    # base.remove_checkout_step :confirm
  end

  Spree::Order.prepend self
end
