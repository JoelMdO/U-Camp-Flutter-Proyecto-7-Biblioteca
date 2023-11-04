import 'package:flutter/widgets.dart';

///MediaQuery for the different widgets resize as per mobile screen measures.
///to be exported as [ScreenSize myScreenSize ScreenSize();]
///
class ScreenSize {
  final double screenWidth;
  final double screenHeight;

  ScreenSize(BuildContext context)
      : screenWidth = MediaQuery.sizeOf(context).width,
        screenHeight = MediaQuery.sizeOf(context).height;
}
