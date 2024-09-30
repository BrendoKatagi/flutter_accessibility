import 'package:flutter_accessibility/domain/entities/book_entity.dart';

class BookDatasource {
  Future<List<BookEntity>> getBooks() async {
    await Future.delayed(const Duration(seconds: 2));
    return books;
  }
}

final List<BookEntity> books = [
  BookEntity(index: 1, imagePath: "assets/images/livro.png", author: '', title: 'Livro 1', price: 56.30),
  BookEntity(index: 2, imagePath: "assets/images/livro2.png", author: 'Machado de Assis', title: 'Dom Casmurro', price: 22.50),
  BookEntity(index: 3, imagePath: "assets/images/livro3.png", author: 'Tolkien', title: 'Senhor dos anéis', price: 105.00),
];
