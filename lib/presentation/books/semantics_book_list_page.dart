import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/semantics.dart';
import 'package:flutter_accessibility/presentation/books/cubit/books_cubit.dart';
import 'package:flutter_accessibility/presentation/books/empty_page.dart';
import 'package:flutter_accessibility/presentation/books/resources/book_strings.dart';
import 'package:flutter_accessibility/presentation/books/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_accessibility/presentation/books/widgets/semantics/semantics_book_card.dart';
import 'package:flutter_accessibility/presentation/books/widgets/semantics/semantics_discount_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SemanticsBookListPage extends StatefulWidget {
  const SemanticsBookListPage({super.key});

  @override
  State<SemanticsBookListPage> createState() => _SemanticsBookListPageState();
}

class _SemanticsBookListPageState extends State<SemanticsBookListPage> {
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
      child: BlocConsumer<BooksCubit, BooksState>(
        listener: (_, __) {},
        listenWhen: (previous, current) {
          if (previous is BooksSuccess && current is BooksSuccess && previous.cartItems.length != current.cartItems.length) {
            //Added announce when cart is updated
            SemanticsService.announce('Carrinho atualizado, você possui ${BookStrings.cartLabel(current.cartItems.length)}', TextDirection.ltr);
          }
          return previous != current;
        },
        builder: (context, state) {
          return Semantics(
            //PAGE ANNOUNCE
            label: 'Página de livros',
            explicitChildNodes: true,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                leading: Semantics(
                    //added semantics for back button
                    label: 'Voltar',
                    button: true,
                    onTap: () => Navigator.of(context).pop(),
                    onTapHint: 'Voltar',
                    excludeSemantics: true,
                    child: BackButton(onPressed: () => Navigator.of(context).pop())),
                // USE OF EXCLUDE SEMANTICS
                title: const ExcludeSemantics(child: Text('Loja de livros')),
                actions: [
                  if (state is BooksSuccess)
                    // ADDED BUTTON LABEL, HINT AND onTapHint
                    Semantics(
                      label: 'carrinho',
                      button: true,
                      hint: BookStrings.cartLabel(state.cartItems.length),
                      onTap: () {},
                      onTapHint: 'acessar carrinho',
                      excludeSemantics: true,
                      child: Badge(
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
                    ),
                ],
              ),
              bottomNavigationBar: const CustomBottomNavigationBar(),
              body: Builder(builder: (context) {
                if (state is BooksLoading) {
                  //Added announce for loading state
                  SemanticsService.announce('Carregando lista de livros', TextDirection.ltr);
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
                        //Added label
                        Semantics(
                          label: 'Seção: livros populares',
                          excludeSemantics: true,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 42, bottom: 8),
                            child: Text(
                              'Populares:',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                            ),
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
                                    SemanticsBookCard(
                                      book: book,
                                      addedToCart: state.cartItems.contains(book),
                                      semanticsLabel: '${book.title} , item ${pagePosition + 1} de ${state.books.length}',
                                      semanticsHint: BookStrings.carouselHint(pagePosition, state.books.length),
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
                        //USE OF SEMANTICS LABEL
                        Semantics(
                          label: 'Seção descontos',
                          excludeSemantics: true,
                          child: const Text(
                            'Descontos:',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(child: SemanticsDiscountCard())
                      ],
                    ),
                  );
                }

                return const SizedBox();
              }),
            ),
          );
        },
      ),
    );
  }
}
