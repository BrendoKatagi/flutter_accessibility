import 'package:flutter/material.dart';
import 'package:flutter_accessibility/presentation/books/semantics_book_list_page.dart';
import 'package:flutter_accessibility/presentation/home_page.dart';
import 'package:flutter_accessibility/presentation/books/book_list_page.dart';

class AppRoutes {
  static navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage(title: '')),
    );
  }

  static navigateToBookListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookListPage()),
    );
  }

  static navigateToSemanticsBookListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SemanticsBookListPage()),
    );
  }
}
