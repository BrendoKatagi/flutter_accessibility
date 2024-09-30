class BookStrings {
  static String cartLabel(int items) => items == 1 ? '$items item adicionado' : '$items itens adicionados';
  static String updateCart(bool cartContainsItem, String bookTitle) => cartContainsItem ? 'remover $bookTitle do carrinho' : 'adicionar $bookTitle ao carrinho';
  static String carouselHint(int position, int length) =>
      (position + 1) != length ? 'Arraste para acessar o próximo da lista' : 'Arraste para acessar o item anterior da lista';
}
