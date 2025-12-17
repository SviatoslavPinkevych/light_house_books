class BooksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_book, only: %i[show edit update destroy]
  before_action :require_admin, only: %i[new create edit update destroy]

  def index
    if params[:q].present?
      q = "%#{params[:q].downcase}%"
      @books = Book.where("LOWER(title) LIKE ? OR LOWER(author) LIKE ?", q, q)
    else
      @books = Book.all
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "Книга успішно створена."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Книгу оновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy!
    redirect_to books_url, notice: "Книга видалена.", status: :see_other
  end

  private

  def require_admin
    unless user_signed_in? && current_user.admin?
      redirect_to books_path, alert: "У вас немає прав для цієї дії."
    end
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :image)
  end
end
