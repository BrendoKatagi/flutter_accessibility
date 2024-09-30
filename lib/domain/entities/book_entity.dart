import 'package:equatable/equatable.dart';

class BookEntity implements Equatable {
  final int index;
  final String imagePath;
  final String author;
  final String title;
  final double price;

  BookEntity({
    required this.index,
    required this.author,
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  List<Object?> get props => [
        index,
        author,
        imagePath,
        title,
        price,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
