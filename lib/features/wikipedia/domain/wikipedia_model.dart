class ArticleModel {
  const ArticleModel({
    required this.id,
    required this.title,
    required this.extract,
    required this.url,
    required this.length,
    required this.touched,
    required this.categories,
    required this.links,
  });

  final int id;
  final String title;
  final String extract;
  final String url;

  final int length;
  final DateTime touched;

  final List<String> categories;

  final List<String> links;
}