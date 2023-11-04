import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_search_opendialog/button_search_opendialog.dart';
import 'package:flutter/material.dart';

///[EmptyLibrary] widget which is displayed when there is no current reading book,
///to let the user know., it has a button [ButtonSearchOpenDialog] when used
///the user is redirected to the [SearchBookPage] to start a search of books
///
class EmptyLibrary extends StatelessWidget {
  const EmptyLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreen = ScreenSize(context);

    return Container(
        height: myScreen.screenHeight * 0.5,
        width: myScreen.screenWidth,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.topStart,
            children: [
              Positioned(
                  top: 25,
                  left: 30,
                  child: Image.asset('assets/emptybook.png')),
              Positioned(
                  top: 15,
                  left: 70,
                  child:
                      const Text('Start reading').continueReadingTextStyle()),
              const Positioned(
                  top: 55, left: 75, child: ButtonSearchOpenDialog()),
            ]));
  }
}
