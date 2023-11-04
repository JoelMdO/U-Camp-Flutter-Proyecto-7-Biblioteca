import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_book_purple/button_bookpurple.dart';
import 'package:books_app/widgets/results_search_page_widgets/result_search_opendialog_bookdetails/button_close_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///[OpenDialogBookDetails] used to show in a dialog more information about an specific
///book after the user selects it by tapping, in the [ResultSearchBook] page includes the
///[PurpleButton] to allow the user to save the book in their library for reading purposes
///that is the reason of the requirement of the information as title, author, context, etc.
///the [dialogContext] which receives has the purpose to let the purple button get the open
///dialog context and allow it to be closed automatically.
///
class OpenDialogBookDetails {
  static Future<void> openDB(BuildContext context, String title, String author,
      String imageUrl, String description, String selfLink) async {
    ScreenSize myscreen = ScreenSize(context);
    double screenWidth = myscreen.screenWidth;
    double screenHeight = myscreen.screenHeight * 0.6;
    final image = imageUrl;
    final bookResume = description;

    return showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: buildBookCover(screenWidth, screenHeight, image),
            content: buildBookContent(screenWidth, screenHeight, bookResume),
            actions: <Widget>[
              buildContentActionsDialog(screenWidth, screenHeight, title,
                  author, image, selfLink, dialogContext)
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
      double screenWidth, double screenHeight, String bookResume) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
            width: screenWidth,
            height: screenHeight * 0.6,
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
                child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(bookResume).openDialogtTextStyle())))));
  }

  ///actions:
  static Widget buildContentActionsDialog(
      double screenWidth,
      double screenHeight,
      String title,
      String author,
      String image,
      String selfLink,
      BuildContext dialogContext) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ButtonBookPurple(
          buttonType: 'Save',
          title: title,
          author: author,
          image: image,
          selfLink: selfLink,
          parentContext: dialogContext),
      const CloseButtonOpenDialog(),
    ]);
  }
}
