import 'package:bloc/bloc.dart';
import 'package:flutter_accessibility/data/book_datasource.dart';
import 'package:flutter_accessibility/domain/entities/book_entity.dart';
import 'package:meta/meta.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksInitial());

  Future<void> loadBooks() async {
    emit(BooksLoading());

    try {
      final List<BookEntity> bookList = await BookDatasource().getBooks();
      if (isClosed) return;
      if (bookList.isEmpty) return emit(BooksEmpty());

      emit(BooksSuccess(books: bookList, cartItems: const <BookEntity>[]));
    } catch (error) {
      addError(error);
      emit(BooksError());
    }
  }

  void updateCart(BookEntity book) {
    final currentState = state as BooksSuccess;
    final List<BookEntity> cart =
        currentState.cartItems.contains(book) ? [...currentState.cartItems.where((item) => item != book)] : [...currentState.cartItems, book];
    emit(BooksSuccess(books: currentState.books, cartItems: cart));
  }
}
