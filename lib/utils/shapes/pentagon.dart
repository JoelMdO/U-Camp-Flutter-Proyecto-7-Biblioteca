import 'package:books_app/utils/colors.dart';
import 'package:flutter/material.dart';

/// [PentagonShape] provides the purple shape in the carrousel figure.
///
class PentagonShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1
    Paint paintFill0 = Paint()
      ..color = Colores.green
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0033333, size.height * 0.1428571);
    path_0.lineTo(size.width * 1.0025000, size.height * 0.1428571);
    path_0.lineTo(size.width * 1.0008333, size.height * 0.8571429);
    path_0.lineTo(size.width * 0.0033333, size.height * 0.8614286);
    path_0.lineTo(size.width * 0.0033333, size.height * 0.1428571);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = Colores.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);

    // Layer 1

    Paint paintFill1 = Paint()
      ..color = Colores.purple
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 1.0025000, size.height * 0.1428571);
    path_1.lineTo(size.width * 0.6266667, size.height * 0.1414286);
    path_1.lineTo(size.width * 0.4583333, size.height * 0.5128571);
    path_1.lineTo(size.width * 0.6258333, size.height * 0.8571429);
    path_1.lineTo(size.width, size.height * 0.8557143);
    path_1.lineTo(size.width * 1.0025000, size.height * 0.1428571);
    path_1.close();

    canvas.drawPath(path_1, paintFill1);

    // Layer 1

    Paint paintStroke1 = Paint()
      ..color = Colores.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paintStroke1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
