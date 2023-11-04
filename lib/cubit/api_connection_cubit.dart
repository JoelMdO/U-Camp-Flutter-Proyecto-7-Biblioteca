import 'dart:convert';
import 'package:books_app/src/data/models/book_model.dart';
import 'package:books_app/src/data/models/library_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
part 'api_connection_state.dart';

/// Cubit created in order to manage the connection with the Nodejs API REST
/// has a initial state for checking if the app is connected with the API [checkConnection]
/// and also has methods to retrieve information from the API as [onlineSearchBook] for
/// google books search, [saveLibraryBook] for saving the book selected in the local
/// SQlite database, [toread] in order to retrieve from the db the books to be read
/// and which are already selected, those books can be found in the Library page
/// also [readagain] to read again a book [favorites] as implicty the name recalls and
/// [reading] which gives the user the selection of the current book reading.
///

class ApiConnectionCubit extends Cubit<ApiConnectionState> {
  ApiConnectionCubit() : super(ApiConnectionState.initial) {
    checkConnection();
  }

  final port = dotenv.env['SERVER_PORT'];

  /// [Localhost] Incase of testing on android emulator consider to change the IP according to the
  /// WiFi IP you are connected as Nodejs will connect in localhost but is not the same
  /// as the android emulator.
  final localhost = dotenv.env['IP'];
  final key = dotenv.env['APIKey'];
  late String searchType;
  Future<void> checkConnection() async {
    Uri nodeJSAPI = Uri.parse('http://$localhost:$port');
    try {
      final response = await http.get(nodeJSAPI);
      if (response.statusCode == 200) {
        emit(ApiConnectionState.connected);
      } else {
        emit(ApiConnectionState.disconnected);
      }
    } catch (e) {
      emit(ApiConnectionState.failure);
    }
  }

  /// [switch_cases] mentioned below are according to the type of [carrousel]
  /// selection in the search page, which will provide the type of search in terms
  /// of the carrousel selected, title referst to the TextField out of the carrousel
  /// referring by two inputs [searchType] and [searchSubject] the retrieve of the
  /// information is more accurate.
  ///
  Future<Book> onlineSearchBook(String searchType, String searchSubject) async {
    switch (searchType) {
      case 'genre':
        searchType = 'genre';
        searchSubject = searchSubject.toString();
        break;
      case 'title':
        searchType = 'intitle';
        break;
      case 'FreeBooks':
        searchType = 'free+books';
        break;
      case 'new releases':
        searchType = '2023';
        searchSubject = '&orderBy=newest&maxResults=10';
        break;
      case 'freetext':
        searchType = '';
        break;
    }
    Uri nodeJSAPI = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$searchType:$searchSubject&&filter=partial&key=$key&country=QA');
    final response = await http.get(nodeJSAPI);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final books = Book.fromJson(jsonResponse);
      return books;
    } else {
      throw Exception('Error on Response: ${response.statusCode}');
    }
  }

  ///[saveLibraryBook] has a map inside with the purpose to use only one table
  ///in this way by default values the columns to be used for filling the library
  ///will be populated once the book is initially saved.
  ///
  Future<int> saveLibraryBook(String title, String author, String image,
      String selfLink, String previewLink) async {
    final Map<String, dynamic> bookToSave = {
      'title': title,
      'author': author,
      'cover': image,
      'selfLink': selfLink,
      'previewLink': previewLink,
      'toread': true,
      'readagain': false,
      'favorites': false,
      'reading': false,
    };

    final jsonBodyforNodeJSAPI = json.encode(bookToSave);
    Uri nodeJSAPI = Uri.parse('http://$localhost:$port/libraryBook');
    final response = await http.post(
      nodeJSAPI,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBodyforNodeJSAPI,
    );
    if (response.statusCode == 201) {
      final statusCode = response.statusCode;
      return statusCode;
    } else {
      throw Exception('Error on Response: ${response.statusCode}');
    }
  }

  Future<Library> toread(toread) async {
    Uri nodeJSAPI =
        Uri.parse('http://$localhost:$port/libraryBook/toread/$toread');

    final response = await http.get(nodeJSAPI);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final toread = Library.fromJson(jsonResponse);
      return toread;
    } else {
      throw Exception('Error on Response: ${response.statusCode}');
    }
  }

  Future<Library> readagain(readagain) async {
    Uri nodeJSAPI =
        Uri.parse('http://$localhost:$port/libraryBook/readagain/$readagain');

    final response = await http.get(nodeJSAPI);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final readagain = Library.fromJson(jsonResponse);
      return readagain;
    } else {
      throw Exception('Error on Response: ${response.statusCode}');
    }
  }

  Future<Library> favorites(favorites) async {
    Uri nodeJSAPI =
        Uri.parse('http://$localhost:$port/libraryBook/favorites/$favorites');

    final response = await http.get(nodeJSAPI);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final favorites = Library.fromJson(jsonResponse);
      return favorites;
    } else if (response.statusCode == 404) {
      return Future.error('No book to read');
    } else {
      throw Exception('Error on Response: ${response.statusCode}');
    }
  }

  Future<Library> reading(reading) async {
    Uri nodeJSAPI =
        Uri.parse('http://$localhost:$port/libraryBook/reading/$reading');

    final response = await http.get(nodeJSAPI);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final readingback = Library.fromJson(jsonResponse);
      return readingback;
    } else if (response.statusCode == 404) {
      return Future.error('No book to read');
    } else {
      throw Exception('Error on Response: ${response.statusCode}');
    }
  }
}
