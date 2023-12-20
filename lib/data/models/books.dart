class Book {
  final String title;
  final String author;
  final String imageUrl;
  final String url;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'],
      author: json['volumeInfo']['authors'] != null
          ? json['volumeInfo']['authors'][0]
          : 'Unknown Author',
      imageUrl: json['volumeInfo']['imageLinks']['thumbnail'],
      url: json['volumeInfo']['infoLink'],
    );
  }
}
