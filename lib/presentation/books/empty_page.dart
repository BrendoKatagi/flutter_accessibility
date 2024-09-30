import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Ocorreu um erro ao obter os dados :(\n tente novamente mais tarde',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
