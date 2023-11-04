import 'package:flutter/material.dart';

///[TriangleShape] provides the shape of the orange triangle showed in the
///carrousel and used as part of the dropwdown list in the [genre] and as
///button in the [new_releases] and [free_books] carrousel
///
class TriangleShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height); // Bottom-left corner
    path.lineTo(size.width / 2, 0); // Top-center vertex
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
