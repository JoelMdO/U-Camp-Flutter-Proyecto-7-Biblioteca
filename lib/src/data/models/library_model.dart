///the model [Library] has the purpose to interact with the books local database,
///after the user has saved one book from the [ResultsPage] the model library will
///have the intention to map the information to be shown in the different widgets
///which interact with the database.

class Library {
  final String message;
  final List<BookLibrary> loadbook;

  Library({
    required this.message,
    required this.loadbook,
  });

  Map<String, dynamic> toJson() => {
        "message": message,
        "loadbook": loadbook.map((item) => item.toJson()).toList(),
      };

  factory Library.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> booksList = json['loadbook'] is List
        ? List<Map<String, dynamic>>.from(json['loadbook'])
        : [json['loadbook']];

    final List<BookLibrary> books =
        booksList.map((bookJson) => BookLibrary.fromJson(bookJson)).toList();

    return Library(
      message: json['message'],
      loadbook: books,
    );
  }
}

class BookLibrary {
  int bookId;
  String title;
  String author;
  String cover;
  String selfLink;
  String previewLink;
  bool toread;
  bool readagain;
  bool favorites;
  bool reading;

  BookLibrary({
    required this.bookId,
    required this.title,
    required this.author,
    required this.cover,
    required this.selfLink,
    required this.previewLink,
    required this.toread,
    required this.readagain,
    required this.favorites,
    required this.reading,
  });

  factory BookLibrary.fromJson(Map<String, dynamic> json) {
    return BookLibrary(
      bookId: json['book_id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      cover: json['cover'] ?? '',
      selfLink: json['selfLink'] ?? '',
      previewLink: json['previewLink'] ?? '',
      toread: json['toread'] ?? false,
      readagain: json['readagain'] ?? false,
      favorites: json['favorites'] ?? false,
      reading: json['reading'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_id': bookId,
      'title': title,
      'author': author,
      'cover': cover,
      'selfLink': selfLink,
      'previewLink': previewLink,
      'toread': toread ? 1 : 0,
      'readagain': readagain ? 1 : 0,
      'favorites': favorites ? 1 : 0, // Convert true to 1, false to 0
      'reading': reading ? 1 : 0,
    };
  }
}
