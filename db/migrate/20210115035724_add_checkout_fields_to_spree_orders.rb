class AddCheckoutFieldsToSpreeOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_orders, :checkout_identifier, :string
  end
end
