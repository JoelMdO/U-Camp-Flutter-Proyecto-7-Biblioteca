import 'package:books_app/screens/reading_page.dart';

///[UrlRenameExtention] due to Android restrictions to retrieve websites non
///https, the below will replace if founded the http for https by substracting
///the 7 characters of http.
///
extension UrlRenameExtention on ReadingPage {
  String convertHttpToHttps(String url) {
    if (url.startsWith("http://")) {
      url = "https://${url.substring(7)}";
    }
    return url;
  }
}

///[UrlLinkExtention] at the current stage of the app, this class has the purpose
///to provide static features to the [ReadingPage] in case the user goes by clicking
///in the navigation bar button [Continue_Reading], as the reading page has three main
///options to access it, once via navigation bar, second through the oval reading widget
///and third through the library after book selection.
///
class UrlLinkExtention {
  static const previewLink =
      'https://books.google.com.qa/books?id=cq6REAAAQBAJ&printsec=frontcover&dq=intitle:flutter&hl=&as_brr=3&cd=7&source=gbs_api';
  static const title = 'Taking Flutter to the Web';
  static const cover =
      'http://books.google.com/books/content?id=cq6REAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api';
}
