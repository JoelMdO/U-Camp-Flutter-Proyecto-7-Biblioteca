import 'package:flutter/material.dart';

///Button to be used to close all the openDialogs in the app
///
class CloseButtonOpenDialog extends StatelessWidget {
  const CloseButtonOpenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Close X'),
    );
  }
}
