class AddPaymentToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :paid, :boolean
  end
end
