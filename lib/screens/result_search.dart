import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/src/data/models/book_model.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/connection_state_extention.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_navigation_bar/button_navgation_bar_addedroutes.dart';
import 'package:books_app/widgets/no_internet_connection_widgets.dart';
import 'package:books_app/widgets/results_search_page_widgets/result_search_opendialog_bookdetails/opendialog_book.dart';
import 'package:books_app/widgets/results_search_page_widgets/results_search_recommend_section.dart';
import 'package:books_app/widgets/title_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///The [ResultSearchBook] page has the purpose to show the books query results
///it has been set up by a [Grid_builder] to show the books. Each of the books
///can be accessed for more details through an opend dialog [OpenDialogBookDetails.openDB]
///who will pop up title, cover picture, and description of the book
///
class ResultSearchBook extends StatefulWidget {
  final String searchType, searchSubject;
  const ResultSearchBook(
      {Key? key, required this.searchType, required this.searchSubject})
      : super(key: key);

  @override
  State<ResultSearchBook> createState() => _ResultSearchBookState();
}

class _ResultSearchBookState extends State<ResultSearchBook> {
  bool isConnected = false;

  late Future<Book> book;
  Future<Book> _loadBook() async {
    final cubit = context.read<ApiConnectionCubit>();
    final bookOnline =
        await cubit.onlineSearchBook(widget.searchType, widget.searchSubject);
    return bookOnline;
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreen = ScreenSize(context);
    final apiState = context.watch<ApiConnectionCubit>().state;
    isConnected = apiState.toBool();
    if (isConnected == true) {
      book = _loadBook();
    }
    return Scaffold(
      body: Theme(
          data: ThemeData(useMaterial3: false),
          child: Container(
              width: myScreen.screenWidth,
              height: myScreen.screenHeight * 0.9,
              decoration: const BoxDecoration(color: Colors.white),
              child: isConnected
                  ? Column(children: [
                      const TitlePage(typeofPage: 'results search'),
                      ResultsBookRecommendationSection(
                          resultbook: book,
                          searchType: widget.searchType,
                          searchSubject: widget.searchSubject),
                      Expanded(
                        child: FutureBuilder<Book>(
                          future: book,
                          builder: (BuildContext context,
                              AsyncSnapshot<Book> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              final books = snapshot.data!.items;
                              return GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: books!.length,
                                itemBuilder: (context, index) {
                                  final book = books[index];
                                  final title = book.volumeInfo.title;
                                  final author =
                                      book.volumeInfo.authors?[0].toString() ??
                                          '';
                                  final imageurl = book.volumeInfo.imageLinks
                                          .smallThumbnail ??
                                      '';
                                  final description =
                                      book.volumeInfo.description ??
                                          'The book does not have description';
                                  final selfLink = book.selfLink.toString();
                                  return GestureDetector(
                                      onTap: () {
                                        OpenDialogBookDetails.openDB(
                                          context,
                                          title,
                                          author,
                                          imageurl,
                                          description,
                                          selfLink,
                                        );
                                      },
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
                                                  width: myScreen.screenWidth,
                                                  child: Text(
                                                    book.volumeInfo.title,
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
                                          ])));
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ])
                  : const Column(children: [
                      NoInternetConnectionMessage(),
                      NoInternetConnectionBox()
                    ]))),
      bottomNavigationBar:
          const ButtonNavigationBarAddedRoutes(type: 'results'),
    );
  }
}
