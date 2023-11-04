import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/widgets/second_page_widgets/searchbook_page_widgets/searchbook_carrousel/searchbook_carrousel_items.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SearchBookCarrousel extends StatelessWidget {
  const SearchBookCarrousel({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    return SizedBox(
        width: myScreenSize.screenWidth,
        child: Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.topStart,
            children: [
              Column(children: [
                CarouselSlider(
                    items: const [
                      SearchBookCarrouselItems(itemType: 'Genre'),
                      SearchBookCarrouselItems(itemType: 'Topic'),
                      SearchBookCarrouselItems(itemType: 'Free\nBooks'),
                      SearchBookCarrouselItems(itemType: 'New\nReleases'),
                    ],
                    options: CarouselOptions(
                      height: 140,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      reverse: true,
                      pauseAutoPlayOnManualNavigate: true,
                      pageSnapping: true,
                      viewportFraction: 0.8,
                    )),
              ]),
              Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/book_carrouselleft.png')),
              Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/book_carrouselright.png')),
            ]));
  }
}
