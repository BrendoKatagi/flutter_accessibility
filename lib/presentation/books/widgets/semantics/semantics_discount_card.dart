import 'package:flutter/material.dart';

class SemanticsDiscountCard extends StatelessWidget {
  const SemanticsDiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'Cupom de desconto. Parabéns, você ganhou um cupom de 10% em todos os nossos livros.',
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/orange_background.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset('assets/images/cupom-de-desconto.png', width: 350, height: 150),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
