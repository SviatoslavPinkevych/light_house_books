class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:book)
  end
  def new
    @book = Book.find(params[:book_id]) if params[:book_id]
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.book_id = params[:book_id] if params[:book_id]

    @order.status = "Очікує підтвердження"
    @order.paid = true   # імітація успішної оплати

    if @order.save
      redirect_to books_path, notice: "Оплату прийнято. Замовлення оформлено!"
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def order_params
    params.require(:order).permit(
      :first_name,
      :last_name,
      :phone,
      :delivery_method,
      :address,
      :payment_method
    )
  end

end
