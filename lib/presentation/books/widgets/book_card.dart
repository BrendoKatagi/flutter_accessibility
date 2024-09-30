import 'package:flutter/material.dart';
import 'package:flutter_accessibility/domain/entities/book_entity.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;
  final bool addedToCart;
  final VoidCallback onPressed;
  final String? semanticsLabel;
  final String? semanticsHint;

  const BookCard({
    super.key,
    required this.book,
    required this.addedToCart,
    required this.onPressed,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              book.imagePath,
            ),
            title: Text(book.title),
            subtitle: Text(book.author),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ExcludeSemantics(
                child: ActionChip(
                  avatar: Icon(addedToCart ? Icons.favorite : Icons.favorite_border),
                  label: Text(addedToCart ? 'Adicionado ' : 'Adicionar'),
                  onPressed: onPressed,
                  backgroundColor: const Color.fromARGB(255, 233, 248, 255),
                  side: const BorderSide(color: Color.fromARGB(255, 145, 181, 199)),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
