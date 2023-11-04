import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/screens/index_page.dart';
import 'package:books_app/screens/reading_page.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_book_purple/button_bookpurple_audio.dart';
import 'package:books_app/widgets/no_internet_connection_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[ButtonBookPurple] is the main button in the application, has four cases:
///[start] used in the home page, [preview] for audio conversion of text,
///[save] to save a book in the local database [start_reading] after selection of
///a book to retrive the [Reading] page. Requires mandatory to receive a [buttonType]
///string to determine the case of use and additional non mandatory more information
///as author, image, etc.
///
class ButtonBookPurple extends StatefulWidget {
  final String buttonType;
  final String? title,
      author,
      image,
      selfLink,
      description,
      weekly,
      previewLink;
  final BuildContext? parentContext;
  const ButtonBookPurple(
      {super.key,
      required this.buttonType,
      this.selfLink,
      this.title,
      this.author,
      this.image,
      this.description,
      this.weekly,
      this.previewLink,
      this.parentContext});

  @override
  State<ButtonBookPurple> createState() => _ButtonBookPurpleState();
}

class _ButtonBookPurpleState extends State<ButtonBookPurple> {
  bool isStart = false;
  bool isConnected = false;
  bool isSaved = false;
  bool isPreview = false;
  bool isOpenToRead = false;
  final String noConnectionPreviewText =
      NoInternetConnectionPreviewText.previewText;
  ApiConnectionCubit cubit = ApiConnectionCubit();

  @override
  void initState() {
    super.initState();
    switch (widget.buttonType) {
      case 'Start':
        isStart = true;
        isPreview = false;
        isSaved = false;
        isOpenToRead = false;
        break;
      case 'Preview':
        isStart = false;
        isPreview = true;
        isSaved = false;
        isOpenToRead = false;
        break;
      case 'Save':
        isStart = false;
        isPreview = false;
        isSaved = true;
        isOpenToRead = false;
      case 'Start Reading':
        isStart = false;
        isPreview = false;
        isSaved = false;
        isOpenToRead = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiState = context.watch<ApiConnectionCubit>().state;
    if (apiState == ApiConnectionState.connected && widget.weekly != 'weekly') {
      isConnected = true;
    } else {
      isConnected = false;
    }

    return InkWell(
        onTap: () {
          isStart
              ? Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const IndexPage(
                        index: 0,
                      )))
              : isPreview
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final bookTextToPreview = isConnected
                            ? widget.description!
                            : noConnectionPreviewText;
                        return AlertDialog(
                          content: ButtonBookPurpleAudio(
                              bookDescripton: bookTextToPreview),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    )
                  : isSaved

                      ///[isSaved] retrieves the corresponded cubit and will close the open dialog
                      ///automatically after 500 miliseconds and show a snackbar to let the user
                      ///know if the book has been saved.
                      ? cubit
                          .saveLibraryBook(
                          widget.title!,
                          widget.author!,
                          widget.image!,
                          widget.selfLink!,
                          widget.previewLink ?? '',
                        )
                          .then((statusCode) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.of(widget.parentContext!).pop();
                          });
                          if (statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colores.orange,
                                content: const Text('Book Saved!')
                                    .noConnectionInternetTextStyle(),
                                action: SnackBarAction(
                                    label: 'Close',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colores.orange,
                                content: const Text(
                                        'Book not saved, please try again!')
                                    .noConnectionInternetTextStyle(),
                                action: SnackBarAction(
                                    label: 'Close',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })));
                          }
                        })
                      : Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.of(widget.parentContext!).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ReadingPage(
                                      link: widget.previewLink,
                                      title: widget.title,
                                      cover: widget.image))));
                        });
        },
        child: Column(children: [
          Text(widget.buttonType).bookRecommendationTextStyle(),
          Image.asset('assets/Purplebook.png')
        ]));
  }
}
