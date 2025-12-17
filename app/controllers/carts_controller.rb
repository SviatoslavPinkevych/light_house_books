class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    session[:cart] ||= []
    @books = Book.where(id: session[:cart])
  end

  def add
    session[:cart] ||= []
    session[:cart] << params[:book_id].to_i
    redirect_to books_path, notice: "Додано в кошик!"
  end

  def remove
    session[:cart] ||= []
    session[:cart].delete(params[:book_id].to_i)
    redirect_to cart_path, notice: "Книгу видалено з кошика."
  end

  def checkout
    session[:cart] ||= []
    books = Book.where(id: session[:cart])

    books.each do |book|
      Order.create!(
        user: current_user,
        book: book,
        first_name: params[:first_name],
        last_name: params[:last_name],
        phone: params[:phone],
        delivery_method: params[:delivery_method],
        address: params[:address],
        payment_method: params[:payment_method],
        status: "Очікує підтвердження",
        paid: true
      )
    end

    session[:cart] = []
    redirect_to books_path, notice: "Замовлення оформлено!"
  end
end
