import 'dart:async';

import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/src/data/models/library_model.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/connection_state_extention.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/no_internet_connection_widgets.dart';
import 'package:books_app/widgets/yourlibrary_page_widgets/opendialog_toreadbook.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowWidgetLibrary extends StatefulWidget {
  final String rowType;
  const RowWidgetLibrary({super.key, required this.rowType});

  @override
  State<RowWidgetLibrary> createState() => _RowWidgetLibraryState();
}

class _RowWidgetLibraryState extends State<RowWidgetLibrary> {
  bool isMyFavorite = false;
  bool isReadAgain = false;
  bool isToRead = false;
  String rowTypeName = '';
  late Future<Library> cubitfromDatabase;

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    final apiState = context.watch<ApiConnectionCubit>().state;
    final isConnected = apiState.toBool();

    if (isConnected == true) {
      final cubit = context.watch<ApiConnectionCubit>();
      if (widget.rowType == 'My Favorites') {
        cubitfromDatabase = cubit.favorites(true);
      } else if (widget.rowType == 'Read Again ') {
        cubitfromDatabase = cubit.readagain(true);
      } else {
        cubitfromDatabase = cubit.toread(true);
      }
    }
    return isConnected
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
                Image.asset('assets/Standingpurplebook.png'),
                Text('${widget.rowType}:  ').bookRecommendationTextStyle(),
                SizedBox(
                    height: 90,
                    width: myScreenSize.screenWidth,
                    child: FutureBuilder<Library>(
                        future: cubitfromDatabase,
                        builder: (BuildContext context,
                            AsyncSnapshot<Library> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.data == null ||
                              snapshot.error == 404 ||
                              snapshot.data!.loadbook.isEmpty) {
                            return Card(
                                elevation: 10.0,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: const BorderSide(
                                        color: Colores.orange, width: 1.0)),
                                color: Colors.white,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      '  No Books stored under this category',
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                    ).bookResultsCardTextStyle()));
                          } else {
                            final libraryBookSelected = snapshot.data;
                            return BlocBuilder<ApiConnectionCubit,
                                ApiConnectionState>(builder: (context, state) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  reverse: false,
                                  itemCount:
                                      libraryBookSelected!.loadbook.length,
                                  itemBuilder: (context, index) {
                                    final book =
                                        libraryBookSelected.loadbook[index];
                                    final imageurl = book.cover;
                                    final title = book.title;
                                    final author = book.author;
                                    final previewLink = book.previewLink;
                                    return InkWell(
                                      onTap: () => OpenDialogToReadBook.openRB(
                                          context,
                                          title,
                                          author,
                                          imageurl,
                                          previewLink),
                                      child: Card(
                                          elevation: 10.0,
                                          shadowColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              side: const BorderSide(
                                                  color: Colores.orange,
                                                  width: 1.0)),
                                          color: Colors.white,
                                          child: Column(children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, top: 5),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    book.title,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ).bookResultsCardTextStyle(),
                                                )),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 5),
                                            ),
                                            Flexible(
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: imageurl,
                                                  width: 80,
                                                  height: 80,
                                                ),
                                              ),
                                            )
                                          ])),
                                    );
                                  });
                            });
                          }
                        }))
              ])
        : const Column(
            children: [
              Center(
                child: NoInternetConnectionMessage(),
              ),
              Center(
                child: NoInternetConnectionBox(),
              )
            ],
          );
  }
}
