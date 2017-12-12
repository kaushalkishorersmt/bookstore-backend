module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_author, only: %i[show, update, destroy]
      before_action :set_book, only: %i[show, update, destroy]

      # GET /books
      def index
        authorize! :read
        @books = @author.books.all
        render json: @books
      end

      # GET /books/1
      def show
        authorize! :read
        render json: @book
      end

      # POST /books
      def create
        authorize! :create
        @book = @author.books.new(book_params)

        if @book.save
          render json: @book, status: :created, location: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /books/1
      def update
        authorize! :update
        if @book.update(book_params)
          render json: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # DELETE /books/1
      def destroy
        authorize! :destroy
        @book.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_book
          @book = @author.books.find(params[:id])
        end

        def set_author
          @author = Author.find(params[:author_id])
        end

        # Only allow a trusted parameter "white list" through.
        def book_params
          params.require(:book).permit(:author_id, :title, :price)
        end
    end
  end
end
