import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class TitlePage extends StatefulWidget {
  final String typeofPage;
  const TitlePage({super.key, required this.typeofPage});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  bool isSearch = false;
  bool isResult = false;
  bool isLibrary = false;

  @override
  void initState() {
    super.initState();
    if (widget.typeofPage == 'search') {
      isSearch = true;
    } else if (widget.typeofPage == 'results search') {
      isResult = true;
    } else if (widget.typeofPage == 'your library') {
      isLibrary = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    return SizedBox(
        width: myScreenSize.screenWidth,
        height: myScreenSize.screenHeight * 0.05,
        child: Column(children: [
          Text(isSearch
                  ? 'Search a new Book'
                  : isResult
                      ? 'Book Results'
                      : isLibrary
                          ? 'Your Library'
                          : 'Weekly recommendation')
              .pageTitleStyle(),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Container(
              height: 4,
              width: myScreenSize.screenWidth * 0.75,
              color: Colores.greenflour,
            ),
          )
        ]));
  }
}
