import 'package:books_app/screens/reading_page.dart';
import 'package:books_app/screens/second_page.dart';
import 'package:books_app/screens/your_library.dart';
import 'package:books_app/widgets/appbar.dart';
import 'package:books_app/widgets/buttons/button_navigation_bar/button_navgation_bar.dart';
import 'package:flutter/material.dart';

///[IndexPage] has as its named the list of main pages to be considered in the bottom
///navigation bar which can be accesed independently of the normal user flow, the pages
///are [weekly] to refer to the Weekly Recommendation page, [Search] page, [Library] page
///and [Reading] page.

class IndexPage extends StatefulWidget {
  final int index;
  const IndexPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isConnected = false;
  int currentPageIndex = 0;
  String image = '';
  String title = '';
  bool isLibrary = false;
  bool isSearch = false;

  late List<Widget> pages = [
    const SecondPage(typeOfPage: 'weekly'),
    const SecondPage(typeOfPage: 'search'),
    const YourLibrary(),
    const ReadingPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(25.0), child: AppBarCustom()),
        body: pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber[800],
          selectedIndex: currentPageIndex,
          backgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 500),
          destinations: const [
            ButtonNavigationBarIndexPage(type: 'weekly'),
            ButtonNavigationBarIndexPage(type: 'search'),
            ButtonNavigationBarIndexPage(type: 'library'),
            ButtonNavigationBarIndexPage(type: 'reading'),
          ],
        ));
  }
}
