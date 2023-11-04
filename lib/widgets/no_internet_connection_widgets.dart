import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NoInternetConnectionMessage extends StatelessWidget {
  const NoInternetConnectionMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colores.blue),
        child: Center(
          child: const Text('Please review your internet connection')
              .noConnectionInternetTextStyle(),
        ));
  }
}

class NoInternetConnectionBox extends StatelessWidget {
  const NoInternetConnectionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(color: Colores.blue),
        child: const Center(
          child: Icon(
            Icons.wifi_off,
            size: 50,
            color: Colors.amber,
          ),
        ));
  }
}

class NoInternetConnectionPreviewText {
  static String previewText =
      'Que se te suba el muerto es una cosa, pero, que se acueste a un costado de ti es muy diferente... Jared nos relata mas que historias, su vida, aquellas vivencias que para Él son a cada momento, en cada instante y en todo lugar. Todos somos actores de la mejor historia personal llamada vida. Mi proposito compartir la historia de Jared.';
}

class ReadindNoConnectionMessage extends StatelessWidget {
  const ReadindNoConnectionMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colores.blue),
      child: const Text('NOT available\nConnection failed')
          .noConnectionInternetTextStyle(),
    );
  }
}
