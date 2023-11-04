import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_book_purple/button_bookpurple.dart';
import 'package:books_app/widgets/results_search_page_widgets/result_search_opendialog_bookdetails/button_close_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OpenDialogToReadBook {
  static Future<void> openRB(BuildContext context, String title, String author,
      String imageUrl, String previewLink) async {
    ScreenSize myscreen = ScreenSize(context);
    double screenWidth = myscreen.screenWidth;
    double screenHeight = myscreen.screenHeight * 0.6;
    final image = imageUrl;

    return showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: buildBookCover(screenWidth, screenHeight, image),
            content: buildBookContent(screenWidth, screenHeight, title, author),
            actions: <Widget>[
              buildContentActionsDialog(
                  title, image, previewLink, dialogContext)
            ],
          );
        });
  }

  ///title:
  static Widget buildBookCover(
      double screenWidth, double screenHeight, String image) {
    return Stack(children: [
      Row(children: [
        Image.asset('assets/Standingbook.png'),
        Image.asset('assets/BookforImage.png'),
      ]),
      Positioned(
          top: 14,
          left: 9,
          child: CachedNetworkImage(
            imageUrl: image,
            width: 170,
            height: 135,
          )),
    ]);
  }

  ///content:
  static Widget buildBookContent(
      double screenWidth, double screenHeight, String title, String author) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
            width: screenWidth,
            height: screenHeight * 0.3,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colores.cream,
                          Colores.cream,
                          Colores.cream,
                          Colors.orangeAccent,
                          Colores.orange
                        ])),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(children: [
                    Text('Title: $title').pageTitleStyle(),
                    Text('Author: $author').pageTitleStyle(),
                  ]),
                ))));
  }

  ///actions:
  static Widget buildContentActionsDialog(String title, String image,
      String previewLink, BuildContext dialogContext) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ButtonBookPurple(
          buttonType: 'Start Reading',
          title: title,
          image: image,
          previewLink: previewLink,
          parentContext: dialogContext),
      const CloseButtonOpenDialog(),
    ]);
  }
}
