part of 'books_cubit.dart';

@immutable
sealed class BooksState {}

final class BooksInitial extends BooksState {}

final class BooksLoading extends BooksState {}

final class BooksSuccess extends BooksState {
  final List<BookEntity> books;
  final List<BookEntity> cartItems;

  BooksSuccess({required this.books, required this.cartItems});
}

final class BooksEmpty extends BooksState {}

final class BooksError extends BooksState {}
