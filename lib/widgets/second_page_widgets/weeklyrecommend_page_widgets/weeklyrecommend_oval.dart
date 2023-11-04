import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_book_purple/button_bookpurple.dart';
import 'package:flutter/material.dart';

class OvalRecommendWidget extends StatefulWidget {
  const OvalRecommendWidget({super.key});

  @override
  State<OvalRecommendWidget> createState() => _OvalRocommendWidgetState();
}

class _OvalRocommendWidgetState extends State<OvalRecommendWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);

    return Stack(
      fit: StackFit.loose,
      alignment: AlignmentDirectional.topStart,
      children: [
        Positioned(
            left: -45,
            child: SizedBox(
              width: myScreenSize.screenWidth,
              height: myScreenSize.screenHeight * 0.4,
              child: Image.asset(
                'assets/Weeklyshape.png',
              ),
            )),
        const Positioned(
            top: 35,
            right: 130,
            child: ButtonBookPurple(
              buttonType: 'Preview',
              weekly: 'weekly',
            )),
        Positioned(
            top: 85, right: 0, child: Image.asset('assets/Weeklysquare.png')),
        Positioned(
            top: 0, left: 19, child: Image.asset('assets/Standingbook.png')),
        Positioned(
            top: -30, left: 50, child: Image.asset('assets/Bookrecommend.png')),
        Positioned(
            top: 100,
            left: 185,
            child:
                const Text('Based on true story\n Author: Joel Montes de Oca')
                    .bookRecommendationTextStyle()),
      ],
    );
  }
}
