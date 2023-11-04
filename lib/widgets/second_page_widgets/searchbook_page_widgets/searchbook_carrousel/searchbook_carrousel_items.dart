import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/shapes/pentagon.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_carrousel/button_carrousel.dart';
import 'package:books_app/widgets/second_page_widgets/searchbook_page_widgets/searchbook_carrousel/searchbook_dropdown_menu.dart';
import 'package:books_app/widgets/second_page_widgets/searchbook_page_widgets/searchbook_textfield.dart';
import 'package:flutter/material.dart';

class SearchBookCarrouselItems extends StatefulWidget {
  final String itemType;
  const SearchBookCarrouselItems({Key? key, required this.itemType})
      : super(key: key);

  @override
  State<SearchBookCarrouselItems> createState() =>
      _SearchBookCarrouselItemsState();
}

class _SearchBookCarrouselItemsState extends State<SearchBookCarrouselItems> {
  String itemType = '';
  late Widget itemsRightSideSearchOption;

  @override
  void initState() {
    super.initState();
    switch (widget.itemType) {
      case 'Genre':
        itemsRightSideSearchOption = const Positioned(
            top: 35, right: 35, child: SearchBookDropdownMenu());
      case 'Topic':
        itemsRightSideSearchOption = const Positioned(
            top: 50,
            right: 20,
            child: SizedBox(
                width: 180,
                height: 50,
                child: SearchBookTextField(
                  useOfTextField: 'carrousel',
                )));
      case 'Free\nBooks':
        itemsRightSideSearchOption = const Positioned(
            top: 35,
            right: 35,
            child: SizedBox(
                width: 90,
                height: 50,
                child: ButtonCarrousel(typeofbutton: 'free books')));
      case 'New\nReleases':
        itemsRightSideSearchOption = const Positioned(
            top: 35,
            right: 35,
            child: SizedBox(
                width: 90,
                height: 50,
                child: ButtonCarrousel(typeofbutton: 'new releases')));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    return SizedBox(
        width: myScreenSize.screenWidth * 0.8,
        height: myScreenSize.screenHeight,
        child: Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.topStart,
            children: [
              CustomPaint(
                size:
                    Size(myScreenSize.screenWidth, (myScreenSize.screenHeight)),
                painter: PentagonShape(),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 30, top: 40),
                  child: Text(widget.itemType).carrouselTitleTextStyle()),
              itemsRightSideSearchOption,
            ]));
  }
}
