import 'package:books_app/screens/index_page.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

///[ButtonSearchOpenDialog] a button used in the [EmptyLibrary] widget which
///is displayed when there is no current reading book, to let the user know.
///if clicked the user is redirected to the [SearchBookPage]
///
class ButtonSearchOpenDialog extends StatelessWidget {
  const ButtonSearchOpenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 20,
      child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IndexPage(index: 1))),
          child: Row(
            children: [
              Image.asset('assets/Pileofbooks.png'),
              const Text('  Search a book').navigationBarTextStyle()
            ],
          )),
    );
  }
}
