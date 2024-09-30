import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_accessibility/presentation/books/semantics_book_list_page.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_semantic_announcements.dart';
import 'mocks/semantic_announcement_matchers.dart';

void main() {
  Future<void> createWidget(WidgetTester tester) => tester.pumpWidget(
        const MaterialApp(
          home: SemanticsBookListPage(),
        ),
      );

  group('accessibility', () {
    testWidgets('Should match semantics strings', (tester) async {
      await createWidget(tester);
      await tester.pumpAndSettle();

      final Finder pageAnnounce = find.bySemanticsLabel('Página de livros');

      final Finder backButton = find.byWidgetPredicate((widget) =>
          widget is Semantics &&
          widget.properties.button == true &&
          widget.properties.label == 'Voltar' &&
          widget.properties.hintOverrides?.onTapHint == 'Voltar');

      final Finder cartButton = findByButtonLabel(label: 'carrinho', hint: '0 itens adicionados', onTapHint: 'acessar carrinho');

      final Finder discountImage = find.byWidgetPredicate((widget) =>
          widget is Semantics &&
          widget.properties.image == true &&
          widget.properties.label == 'Cupom de desconto. Parabéns, você ganhou um cupom de 10% em todos os nossos livros.');

      expect(pageAnnounce, findsOneWidget);
      expect(backButton, findsOneWidget);
      expect(cartButton, findsOneWidget);
      expect(discountImage, findsOneWidget);
    });

    testWidgets('Should announce when page is loading', (tester) async {
      final MockSemanticAnnouncements mockSemanticAnnouncements = MockSemanticAnnouncements(tester);
      const AnnounceSemanticsEvent expectedAnnouncement = AnnounceSemanticsEvent('Carregando lista de livros', TextDirection.ltr);

      await createWidget(tester);
      await tester.pumpAndSettle();

      expect(mockSemanticAnnouncements.announcements, hasOneAnnouncement(expectedAnnouncement));
    });

    testWidgets('Should announce when item is added to cart', (tester) async {
      final MockSemanticAnnouncements mockSemanticAnnouncements = MockSemanticAnnouncements(tester);
      const AnnounceSemanticsEvent expectedAnnouncement = AnnounceSemanticsEvent('Carregando lista de livros', TextDirection.ltr);
      const AnnounceSemanticsEvent expectedCartUpdate = AnnounceSemanticsEvent('Carrinho atualizado, você possui 1 item adicionado', TextDirection.ltr);

      await createWidget(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Adicionar').first);
      await tester.pumpAndSettle();

      final Finder cartButton = findByButtonLabel(label: 'carrinho', hint: '1 item adicionado', onTapHint: 'acessar carrinho');

      expect(mockSemanticAnnouncements.announcements, hasNAnnouncements([expectedAnnouncement, expectedCartUpdate]));
      expect(cartButton, findsOneWidget);
    });
  });
}

Finder findByButtonLabel({required String label, required String onTapHint, String? hint}) => find.byWidgetPredicate(
      (widget) =>
          widget is Semantics &&
          widget.properties.button == true &&
          widget.properties.label == label &&
          widget.properties.hint == hint &&
          widget.properties.hintOverrides?.onTapHint == onTapHint,
    );
