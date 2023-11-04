import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/widgets/second_page_widgets/searchbook_page_widgets/searchbook_page_widget.dart';
import 'package:books_app/widgets/second_page_widgets/weeklyrecommend_page_widgets/weeklyrecommend_page.dart';
import 'package:flutter/material.dart';

/// With the objective to use conmponents, the [SecondPage] has the purpose to
/// be as mockup, considering the connection to the network if its available
/// or not and pop up two pages one [SearchPage] and the second [WeeklyRecommendation]
class SecondPage extends StatefulWidget {
  final String typeOfPage;
  const SecondPage({super.key, required this.typeOfPage});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isSearch = false;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    if (widget.typeOfPage == 'search') {
      isSearch = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          right: true,
          left: true,
          child: Container(
              width: myScreenSize.screenWidth,
              height: myScreenSize.screenHeight,
              decoration: const BoxDecoration(color: Colors.white),
              child: isSearch
                  ? const SearchBookPage()
                  : const WeeklyRecommendPage())),
    );
  }
}
