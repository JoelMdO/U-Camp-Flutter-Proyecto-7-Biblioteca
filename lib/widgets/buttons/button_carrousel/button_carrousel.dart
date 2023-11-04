import 'package:books_app/screens/result_search.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/shapes/triangle.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

///[ButtonCarrousel] has two main uses, one for the carrousel option
///[New_releases] to get the new books in order to determine the type of
///url needed for this purpose and second the [Free_books] both will head
///to the [ResultSearchBook] page on a different query.
///
class ButtonCarrousel extends StatelessWidget {
  final String typeofbutton;
  const ButtonCarrousel({super.key, required this.typeofbutton});

  @override
  Widget build(BuildContext context) {
    String searchType = '';
    String searchSubject = '';

    switch (typeofbutton) {
      case 'new releases':
        searchType = 'November';
        searchSubject = '2023';
      case 'free books':
        searchSubject = 'free+books';
    }
    return InkWell(
      child: Row(
        children: [
          const Text('Click here').carrouselButtonTextStyle(),
          Transform.rotate(
              angle: math.pi,
              child: ClipPath(
                  clipper: TriangleShape(),
                  child: Container(
                    width: 15,
                    height: 15,
                    color: Colores.orange,
                  ))),
        ],
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultSearchBook(
                  searchType: searchType, searchSubject: searchSubject))),
    );
  }
}
