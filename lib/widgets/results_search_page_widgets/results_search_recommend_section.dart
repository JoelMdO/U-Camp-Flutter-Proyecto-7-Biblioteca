import 'package:books_app/src/data/models/book_model.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_book_purple/button_bookpurple.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///[ResultsBookRecommendationSection] after the user performs a search this widget
///is used to provide a recommendation book following the topic selected by the user.
///at the stage of the app is taking the book on index 6 as recommendation but should be
///modified on a second phase.
///
class ResultsBookRecommendationSection extends StatefulWidget {
  final String searchType, searchSubject;
  final Future<Book> resultbook;
  const ResultsBookRecommendationSection(
      {super.key,
      required this.searchType,
      required this.searchSubject,
      required this.resultbook});

  @override
  State<ResultsBookRecommendationSection> createState() =>
      _ResultsBookRecommendationSectionState();
}

class _ResultsBookRecommendationSectionState
    extends State<ResultsBookRecommendationSection> {
  get cubit => null;

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);

    return SizedBox(
      width: myScreenSize.screenWidth,
      height: myScreenSize.screenHeight * 0.3,
      child: FutureBuilder(
          future: widget.resultbook,
          builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('No book recommended'));
            } else {
              final resultbook = snapshot.data!.items;
              final bookRecommendedTop =
                  resultbook![6].volumeInfo.title.toString();
              final bookRecommendedTopAuthor =
                  resultbook[6].volumeInfo.authors![0].toString();
              final bookRecommendedTopImage =
                  resultbook[6].volumeInfo.imageLinks.smallThumbnail;
              final bookDescripton = resultbook[6].volumeInfo.description;
              return Stack(
                  fit: StackFit.loose,
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Positioned(
                        top: 60,
                        right: 15,
                        child: SizedBox(
                          width: myScreenSize.screenWidth * 0.7,
                          height: myScreenSize.screenHeight * 0.3,
                          child: Image.asset('assets/CircleRecommend.png'),
                        )),
                    Positioned(
                        top: 38,
                        left: 40,
                        child: const Text('Recommendation:')
                            .bookRecommendationTextStyle()),
                    Positioned(
                        top: 58,
                        left: 40,
                        child: Text(bookRecommendedTop)
                            .bookRecommendationTextStyle()),
                    Positioned(
                      top: 78,
                      left: 40,
                      child: Text('Author: $bookRecommendedTopAuthor')
                          .bookRecommendationTextStyle(),
                    ),
                    Positioned(
                      top: 90,
                      right: 65,
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                          imageUrl: bookRecommendedTopImage!),
                    ),
                    Positioned(
                        top: 120,
                        left: 80,
                        child: ButtonBookPurple(
                            buttonType: 'Preview',
                            description: bookDescripton)),
                  ]);
            }
          }),
    );
  }
}
