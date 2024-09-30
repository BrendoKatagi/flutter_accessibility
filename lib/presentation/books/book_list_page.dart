import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_accessibility/presentation/books/cubit/books_cubit.dart';
import 'package:flutter_accessibility/presentation/books/empty_page.dart';
import 'package:flutter_accessibility/presentation/books/widgets/book_card.dart';
import 'package:flutter_accessibility/presentation/books/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_accessibility/presentation/books/widgets/discount_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.90);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BooksCubit>(
      create: (context) => BooksCubit()..loadBooks(),
      child: BlocBuilder<BooksCubit, BooksState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Loja de livros'),
              actions: [
                if (state is BooksSuccess)
                  Badge(
                    badgeContent: Text(
                      state.cartItems.length.toString(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    position: BadgePosition.bottomStart(bottom: -1, start: 2),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart, size: 30),
                      ),
                    ),
                  ),
              ],
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
            body: Builder(builder: (context) {
              if (state is BooksLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is BooksSuccess && state.books.isEmpty) {
                return const EmptyPage();
              }

              if (state is BooksSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 42, bottom: 8),
                        child: Text(
                          'Populares:',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                          itemCount: state.books.length,
                          controller: pageController,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, pagePosition) {
                            final book = state.books[pagePosition];
                            return Container(
                              margin: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  BookCard(
                                    book: book,
                                    addedToCart: state.cartItems.contains(book),
                                    semanticsLabel: '${book.title} , item ${pagePosition + 1} de ${state.books.length}',
                                    semanticsHint: 'Arraste para acessar o próximo da lista',
                                    onPressed: () {
                                      context.read<BooksCubit>().updateCart(book);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Text(
                        'Descontos:',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Center(child: DiscountCard())
                    ],
                  ),
                );
              }

              return const SizedBox();
            }),
          );
        },
      ),
    );
  }
}
