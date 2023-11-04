import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

/// [NavigationBar] customized a difference of the [ButtonNavigationBarIndexPage]
/// this is only intended for two pages which are not considered as part of the
/// main index but is required to help the user to get back to the previous screen
/// accordingly a switch case [results] and [reading] are the options which by
/// name are used on the corresponded pages where the navigaton bar belongs
///
class ButtonNavigationBarAddedRoutes extends StatelessWidget {
  final String type;
  const ButtonNavigationBarAddedRoutes({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    String textcontent = '';
    ScreenSize myScreenSize = ScreenSize(context);

    switch (type) {
      case 'results':
        textcontent = 'Return to Searchs';
        break;
      case 'reading':
        textcontent = 'Return to Library';
    }

    return Container(
      width: myScreenSize.screenWidth,
      height: myScreenSize.screenHeight * 0.05,
      decoration: BoxDecoration(color: Colores.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new)),
          Text(textcontent).navigationBarTextStyle(),
        ],
      ),
    );
  }
}
