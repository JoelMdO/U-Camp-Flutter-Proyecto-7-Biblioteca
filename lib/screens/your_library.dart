import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/oval_reading/oval_reading_widget.dart';
import 'package:books_app/widgets/no_internet_connection_widgets.dart';
import 'package:books_app/widgets/yourlibrary_page_widgets/row_widget_library.dart';
import 'package:books_app/widgets/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[YourLibrary] in order to populate the information regarding the number of available
///books it has been split in 3 sections [MyFavorites], [ToRead] and [ReadAgain] as
///the names indicate its purpose, it will retrieve the different type of books
///stored in the database after previous selection from the user, the [RowWidgetLibrary]
///has the widget structure of each section, called as RowWidget as it will be shown on
///a row type structure.
///

class YourLibrary extends StatefulWidget {
  const YourLibrary({super.key});

  @override
  State<YourLibrary> createState() => _YourLibraryState();
}

class _YourLibraryState extends State<YourLibrary> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    final apiState = context.watch<ApiConnectionCubit>().state;

    if (apiState == ApiConnectionState.connected) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    return Scaffold(
        body: SafeArea(
      top: true,
      left: true,
      right: true,
      bottom: true,
      child: isConnected
          ? Container(
              width: myScreenSize.screenWidth,
              height: myScreenSize.screenHeight,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  const TitlePage(typeofPage: 'your library'),
                  Image.asset(
                    'assets/LayingBook.png',
                    width: 350,
                    height: 190,
                  ),
                  const Positioned(
                      top: 125,
                      left: 5,
                      child: Column(children: [
                        RowWidgetLibrary(rowType: 'My Favorites'),
                        RowWidgetLibrary(rowType: '  To Read    '),
                        RowWidgetLibrary(rowType: 'Read Again ')
                      ])),
                  const Positioned(
                      bottom: 5,
                      right: 5,
                      child: SizedBox(
                          width: 250,
                          height: 150,
                          child: OvalReadingWidget(oval: 'search'))),
                ],
              ),
            )
          : Column(children: [
              const SizedBox.shrink(),
              const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: NoInternetConnectionMessage()),
              Container(
                  width: myScreenSize.screenWidth,
                  color: Colores.blue,
                  child: Center(
                    child: const Text('Library unavailable')
                        .noConnectionInternetTextStyle(),
                  )),
              const Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Center(child: NoInternetConnectionBox())),
            ]),
    ));
  }
}
