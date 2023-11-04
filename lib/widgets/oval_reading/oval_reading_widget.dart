import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/screens/reading_page.dart';
import 'package:books_app/utils/connection_state_extention.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/no_internet_connection_widgets.dart';
import 'package:books_app/widgets/oval_reading/empty_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[OvalReadingWidget] compose the information of the current book the user is reading
///in case of no current book under the reading category, the widget gets modified and
///with the change of [Visibility] of the widget image oval and add of the [GroupBooks]
///image, as well it has a configuration for connected or not to the API.
///
class OvalReadingWidget extends StatefulWidget {
  final String oval;
  const OvalReadingWidget({
    super.key,
    required this.oval,
  });

  @override
  State<OvalReadingWidget> createState() => _OvalReadingWidgetState();
}

class _OvalReadingWidgetState extends State<OvalReadingWidget> {
  bool image = true;
  ApiConnectionCubit cubit = ApiConnectionCubit();

  @override
  void initState() {
    super.initState();
    if (widget.oval == 'weekly') {
      image = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    final apiState = context.watch<ApiConnectionCubit>().state;
    final isConnected = apiState.toBool();

    if (widget.oval == 'search' && isConnected == true) {
      cubit = context.watch<ApiConnectionCubit>();
    }
    return isConnected
        ? FutureBuilder(
            future: cubit.reading(true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data == null || snapshot.error == 404) {
                return const EmptyLibrary();
              } else {
                final books = snapshot.data!.loadbook;
                final firstBook = books[0];
                print('Futurebuilder: $books');
                final imageurl = firstBook.cover;
                print(imageurl.toString());
                return Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      SizedBox(
                          width: myScreenSize.screenWidth * 0.55,
                          height: myScreenSize.screenHeight * 0.21,
                          child: Visibility(
                              visible: image,
                              child: Image.asset(
                                'assets/CircleContnueReading.png',
                              ))),
                      const SizedBox.shrink(),
                      Positioned(
                          top: 48,
                          left: 40,
                          child: const Text('Continue\nReading')
                              .continueReadingTextStyle()),
                      Positioned(
                        top: 60,
                        left: 80,
                        child: Image.asset(
                          'assets/LayingBook.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Positioned(
                          top: 25,
                          left: 110,
                          child: GestureDetector(
                            onTap: () {
                              var previewLink = firstBook.previewLink;
                              if (previewLink == '') {
                                previewLink =
                                    'Book Does not have an e-reading option.';
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReadingPage(link: previewLink)));
                            },
                            child: CachedNetworkImage(
                              imageUrl: imageurl,
                              width: 70,
                              height: 70,
                            ),
                          ))
                    ]);
              }
            })
        : Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.topStart,
            children: [
                SizedBox(
                    width: myScreenSize.screenWidth * 0.55,
                    height: myScreenSize.screenHeight * 0.21,
                    child: Visibility(
                        visible: image,
                        child: Image.asset(
                          'assets/CircleContnueReading.png',
                        ))),
                Positioned(
                  left: 165,
                  top: 45,
                  child: SizedBox(
                      width: myScreenSize.screenWidth * 0.4,
                      height: 40,
                      child: const ReadindNoConnectionMessage()),
                ),
                Positioned(
                    top: 48,
                    left: 40,
                    child: const Text('Continue\nReading')
                        .continueReadingTextStyle()),
                Positioned(
                  top: 60,
                  left: 80,
                  child: Image.asset(
                    'assets/LayingBook.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                Positioned(
                    top: 25,
                    left: 110,
                    child: Image.asset('assets/GroupBooks.png'))
              ]);
  }
}
