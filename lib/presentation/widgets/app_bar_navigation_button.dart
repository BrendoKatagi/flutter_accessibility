import 'package:flutter/material.dart';

class AppBarNavigationButton extends StatelessWidget {
  final VoidCallback onTap;
  const AppBarNavigationButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.arrow_right_alt, size: 30),
      ),
    );
  }
}
