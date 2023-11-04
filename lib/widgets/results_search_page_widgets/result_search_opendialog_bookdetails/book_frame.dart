import 'package:books_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

///[BookFrameWidget] used to provide the image of frame of the standing red book
///and frame red book in the [WeeklyRecommendation] in this stage of the app the
///widget book images are static and added by the admin but supose to have an
///option to let the user have a weekly recommendation.
///
class BookFrameWidget extends StatelessWidget {
  const BookFrameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: AlignmentDirectional.topStart,
      children: [
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
