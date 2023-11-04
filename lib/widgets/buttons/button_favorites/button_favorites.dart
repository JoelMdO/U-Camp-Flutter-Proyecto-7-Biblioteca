import 'package:books_app/utils/colors.dart';
import 'package:flutter/material.dart';

///[ButtonFavorites] placed in the [ReadingPage] where the user
///can use it, on the second phase of the app is intended to add
///the interaction with API in order to modified the database and
///assign the book if its favored to the favorite class.
///
class ButtonFavorites extends StatefulWidget {
  const ButtonFavorites({super.key});

  @override
  State<ButtonFavorites> createState() => _ButtonFavoritesState();
}

class _ButtonFavoritesState extends State<ButtonFavorites> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: isFavorite
            ? const Icon(
                Icons.star,
                color: Colores.orange,
              )
            : const Icon(
                Icons.star_border,
                color: Colores.greenflour,
              ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        });
  }
}
