import 'package:flutter/material.dart';
import 'package:flutter_accessibility/presentation/widgets/app_bar_navigation_button.dart';
import 'package:flutter_accessibility/shared/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: <Widget>[
          AppBarNavigationButton(
            // Navigate to Book List Page to see the example without semantics fixes
            // Navigate to Semantics Book List Page to see the example with semantics fixes
            // onTap: () => AppRoutes.navigateToBookListPage(context),
            onTap: () => AppRoutes.navigateToSemanticsBookListPage(context),
          )
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Semantics APP',
            ),
          ],
        ),
      ),
    );
  }
}
