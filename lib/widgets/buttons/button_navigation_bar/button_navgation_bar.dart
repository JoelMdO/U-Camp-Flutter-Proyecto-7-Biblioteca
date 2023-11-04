import 'package:books_app/screens/index_page.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

/// [ButtonNavigationBarIndexPage] Main [NavigationBar] of the app
/// customized to be used in four main pages [weekly], [search], [library],
/// [reading] the button of each is using [Inkwell] widget.
///
class ButtonNavigationBarIndexPage extends StatelessWidget {
  final String type;
  const ButtonNavigationBarIndexPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    String image = '';
    String title = '';
    bool isLibrary = false;
    bool isSearch = false;
    bool isWeekly = false;

    print('ButtonNavigation: $type');

    switch (type) {
      case 'weekly':
        image = 'assets/Standingpurplebook.png';
        title = 'Weekly\nsuggest';
        isWeekly = true;
        break;
      case 'search':
        image = 'assets/Pileofbooks.png';
        title = 'Search by\ncategories';
        isSearch = true;
        break;
      case 'library':
        image = 'assets/GroupBooks.png';
        title = 'Your\nlibrary';
        isLibrary = true;
        break;
      case 'reading':
        image = 'assets/ContinueReading.png';
        title = 'Continue\nReading';
    }
    return InkWell(
        onTap: () {
          isWeekly
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IndexPage(index: 0)))
              : isSearch
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IndexPage(index: 1)))
                  : isLibrary
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndexPage(index: 2)))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndexPage(index: 3)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 30, height: 30, child: Image.asset(image)),
            Text(title).navigationBarTextStyle()
          ],
        ));
  }
}
