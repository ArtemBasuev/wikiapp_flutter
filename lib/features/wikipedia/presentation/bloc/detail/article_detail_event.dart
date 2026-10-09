sealed class ArticleDetailEvent {
  const ArticleDetailEvent();
}

final class ArticleDetailOpened extends ArticleDetailEvent {
  const ArticleDetailOpened(this.id);

  final int id;
}
