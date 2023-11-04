import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/no_internet_connection_widgets.dart';
import 'package:books_app/widgets/second_page_widgets/searchbook_page_widgets/searchbook_carrousel/searchbook_carrousel.dart';
import 'package:books_app/widgets/oval_reading/oval_reading_widget.dart';
import 'package:books_app/widgets/second_page_widgets/searchbook_page_widgets/searchbook_textfield.dart';
import 'package:books_app/widgets/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBookPage extends StatefulWidget {
  const SearchBookPage({
    super.key,
  });

  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
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

    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange,
          content: Text(isConnected
                  ? 'Succesfully connected to the network'
                  : 'Check your internet connection')
              .noConnectionInternetTextStyle(),
        ),
      );
    });
    return Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.topStart,
        children: [
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 15)),
                const TitlePage(typeofPage: 'search'),
                const Padding(padding: EdgeInsets.only(top: 15)),
                isConnected
                    ? const SearchBookCarrousel()
                    : const NoInternetConnectionMessage(),
                Center(
                    child: SizedBox(
                        width: 250,
                        height: 50,
                        child: isConnected
                            ? const SearchBookTextField(
                                useOfTextField: 'search_page',
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                color: Colors.white,
                              )))),
              ]),
          Padding(
              padding: const EdgeInsets.only(top: 320, left: 15),
              child: isConnected
                  ? const OvalReadingWidget(oval: 'search')
                  : Container(
                      decoration: const BoxDecoration(
                      color: Colors.white,
                    ))),
          Padding(
              padding: const EdgeInsets.only(
                top: 550,
              ),
              child: Container(
                height: 4,
                width: myScreenSize.screenWidth * 0.6,
                color: Colores.greenflour,
              ))
        ]);
  }
}
