import 'package:flutter/material.dart';
import 'package:flutter_accessibility/domain/entities/book_entity.dart';
import 'package:flutter_accessibility/presentation/books/resources/book_strings.dart';

class SemanticsBookCard extends StatelessWidget {
  final BookEntity book;
  final bool addedToCart;
  final VoidCallback onPressed;
  final String? semanticsLabel;
  final String? semanticsHint;

  const SemanticsBookCard({
    super.key,
    required this.book,
    required this.addedToCart,
    required this.onPressed,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      //added label and hint
      label: semanticsLabel,
      hint: semanticsHint,
      child: Card(
        semanticContainer: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //ADDED EXCLUDE SEMANTICS
            ExcludeSemantics(
              child: ListTile(
                leading: Image.asset(
                  book.imagePath,
                ),
                title: Text(book.title),
                subtitle: Text(book.author),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //ADD TO CART BUTON LABEL AND HINT
                Semantics(
                  label: addedToCart ? 'Remover item' : 'Adicionar item',
                  button: true,
                  onTap: onPressed,
                  onTapHint: BookStrings.updateCart(addedToCart, book.title),
                  child: ExcludeSemantics(
                    //EXCLUDE SEMANTICS
                    child: ActionChip(
                      avatar: Icon(addedToCart ? Icons.favorite : Icons.favorite_border),
                      label: Text(addedToCart ? 'Adicionado ' : 'Adicionar'),
                      onPressed: onPressed,
                      backgroundColor: const Color.fromARGB(255, 233, 248, 255),
                      side: const BorderSide(color: Color.fromARGB(255, 145, 181, 199)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
